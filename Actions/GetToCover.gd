extends Action

func name():
	return "GetToCover"

func is_valid(_actor) -> bool:
	if _actor.states["covered"]:
		return false
	if _actor.target == null:
		return false
	return true

func get_cost() -> int:
	# Depends on the distance to nearest cover
	return 3

func get_desireability() -> int:
	return 10

func get_preconditions() -> Dictionary:
	return {
	}

func get_effects() -> Dictionary:
	return {"has_enemy":false}

func perform(_actor) -> bool:
	# Local = Global, Map = Tile
	# local to map = global to tile
	is_running = true
	var possible_cover = Global.level.get_node("Cover").get_children()
	var options:Array = []
	for cover in possible_cover:
		# Evaluate possible factors to get score for each cover
		var cover_position = cover_position(_actor, cover)
		if cover_position == Vector2i(-1,-1):
			continue

		var score:int = 0
		# Distance from actor
		if _actor.position.distance_to(cover_position) < 320:
			score += 1
		# Distance to threat
		var distance_to_threat:float = _actor.target.position.distance_to(cover_position)
		if distance_to_threat > 120 and distance_to_threat < 192:
			score += 1
		options.append([score, cover_position])
		var dot = load("res://CoverDot/CoverDot.tscn").instantiate()
		dot.position = cover_position
		Global.level.add_child(dot)
	var best_score = -10000
	var best_position:Vector2i 
	for option in options:
		if option.front() > best_score:
			best_score = option.front()
			best_position = option.back()
	_actor.move_to(best_position)
	await _actor.get_node("NavigationAgent2D").target_reached
	_actor.change_state("covered",true)
	is_running = false
	return false

func cover_position(actor, cover)->Vector2i:
	# If the actor is able to put the cover between them and the threat
	# Get the cardinal direction of the threat to the cover
	# If the opposite direction is inaccessible (against a wall, etc), its not valid
	var angle = rad_to_deg(cover.position.angle_to_point(actor.target.position))

	var opposite_direction = deg_to_cardinal(angle) * Vector2i(-1,-1)
	var cover_tile = Global.level.local_to_map(cover.position) - opposite_direction
	if not is_tile_reachable(cover_tile):
		return Vector2i(-1,-1)
	
	var cover_position = Global.level.map_to_local(Global.level.local_to_map(cover.position) - opposite_direction)
#	var s = Sprite2D.new()
#	s.texture = load("res://dot.png")
#	Global.level.add_child(s)
#	s.position = cover_position
	return cover_position

func deg_to_cardinal(degree:float)->Vector2i:
	var d:int = round(degree/45)
	if d == 0:
		# West
		return Vector2i(-1,0)
	if d == 1:
		# Northwest
		return Vector2i(-1,-1)
	if d == 2:
		# North
		return Vector2i(0,-1)
	if d == 3:
		# Northeast
		return Vector2i(1,-1)
	if d == 4:
		# East
		return Vector2i(1,0)
	if d == -4:
		# East
		return Vector2i(1,0)
	if d == -3:
		# Southeast
		return Vector2i(1,1)
	if d == -2:
		# South
		return Vector2i(0,1)
	if d == -1:
		# Southwest
		return Vector2i(-1,1)
	# West
	return Vector2i(-1,0)

func is_tile_reachable(tile:Vector2i)->bool:
	return true

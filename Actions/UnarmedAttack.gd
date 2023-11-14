extends Action

func name():
	return "UnarmedAttack"

func is_valid(_actor) -> bool:
	if _actor.target == null:
		return false
	return true

func get_cost() -> int:
	return 10

func get_desireability() -> int:
	return 1

func get_preconditions() -> Dictionary:
	return {}

func get_effects() -> Dictionary:
	return {"has_enemy":false}

func perform(_actor) -> bool:
	is_running = true
	_actor.move_to(_actor.target.position)
	await _actor.get_node("NavigationAgent2D").target_reached
	# The character currently lacks punching functionality, so just stand still for a second
	var tween = Global.create_tween()
	tween.tween_interval(1)
	await tween.finished
	is_running = false
	return false

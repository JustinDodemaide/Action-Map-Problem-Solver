extends Action

func name():
	return "Investigate"

func is_valid(_actor) -> bool:
	if _actor.last_seen_location == Vector2(-1,-1):
		return false
	return true

func get_cost() -> int:
	return 1

func get_desireability() -> int:
	return 1

func get_preconditions() -> Dictionary:
	return {}

func get_effects() -> Dictionary:
	return {"unsure_of_enemy":false,
	}

func perform(_actor) -> bool:
	# Stand-in to simulate the action
	is_running = true
	_actor.move_to(_actor.last_seen_location)
	await _actor.get_node("NavigationAgent2D").target_reached
	_actor.change_state("unsure_of_enemy",false)
	is_running = false
	return false

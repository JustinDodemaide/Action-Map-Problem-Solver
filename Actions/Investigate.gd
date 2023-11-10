extends Action

func name():
	return "Investigate"

func is_valid(_actor) -> bool:
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
	var tween = _actor.create_tween()
	tween.tween_interval(1.5)
	_actor.change_state("unsure_of_enemy", false)
	#if randi_range(0,1) == 0:
	_actor.change_state("has_enemy", true)
	is_running = false
	return false

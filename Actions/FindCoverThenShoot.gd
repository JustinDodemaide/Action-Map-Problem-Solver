extends Action

func name():
	return "FindCoverThenShoot"

func is_valid(_actor) -> bool:
	if _actor.states["covered"]:
		return false
	return true

func get_cost() -> int:
	return 3

func get_desireability() -> int:
	return 10

func get_preconditions() -> Dictionary:
	return {"has_weapon":true
	}

func get_effects() -> Dictionary:
	return {"has_enemy":false}

func perform(_actor) -> bool:
	# Stand-in to simulate the action
	is_running = true
	var tween = _actor.create_tween()
	tween.tween_interval(1.5)
	_actor.change_state("covered", true)
	if randi_range(0,5) == 0:
		_actor.change_state("has_enemy", false)
	is_running = false
	return false

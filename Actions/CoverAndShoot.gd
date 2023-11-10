extends Action

func name():
	return "CoverAndShoot"

func is_valid(_actor) -> bool:
	return true

func get_cost() -> int:
	return 3

func get_desireability() -> int:
	return 10

func get_preconditions() -> Dictionary:
	return {"has_weapon":true}

func get_effects() -> Dictionary:
	return {"has_enemy":false}

func perform(_actor) -> bool:
	# Stand-in to simulate the action
	is_running = true
	var tween = _actor.create_tween()
	tween.tween_interval(1.5)
	if randi_range(0,5) == 0:
		_actor.states["has_enemy"] = false
	is_running = false
	return false

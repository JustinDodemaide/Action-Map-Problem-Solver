extends Action

func name():
	return "StandAndShoot"

func is_valid(_actor) -> bool:
	if _actor.target == null:
		return false
	return true

func get_cost() -> int:
	return 3

func get_desireability() -> int:
	return 5

func get_preconditions() -> Dictionary:
	return {"has_weapon":true}

func get_effects() -> Dictionary:
	return {"has_enemy":false}

func perform(_actor) -> bool:
	_actor.shoot()
	return false

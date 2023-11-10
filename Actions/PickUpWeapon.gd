extends Action

func name():
	return "PickUpWeapon"

func is_valid(_agent) -> bool:
	return true

func get_cost() -> int:
	return 1000

func get_desireability() -> int:
	return 1

func get_preconditions() -> Dictionary:
	return {}

func get_effects() -> Dictionary:
	return {"has_weapon":true}

func perform(_actor) -> bool:
	return false

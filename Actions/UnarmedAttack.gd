extends Action

func name():
	return "UnarmedAttack"

func is_valid(_actor) -> bool:
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
	return false

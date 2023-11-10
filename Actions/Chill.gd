extends Action

func name():
	return "Chill"

func is_valid(_actor) -> bool:
	return true

func get_cost() -> int:
	return 1

func get_desireability() -> int:
	return 10

func get_preconditions() -> Dictionary:
	return {"unsure_of_enemy":false,
			"has_enemy":false,
	}

func get_effects() -> Dictionary:
	return {"chill":true}

func perform(_actor) -> bool:
	# Chill promises to set "chill" to true, but never does, so it keeps being selected
	#_actor.states["chill"] = true
	return false

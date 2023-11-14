extends ActionMap

func _init():
	action_map = {
	{"has_enemy":false}: ["UnarmedAttack", "StandAndShoot","FindCoverThenShoot"],
	{"has_weapon":true}: ["PickUpWeapon"],
	{"chill":true}: ["Chill"],
	{"unsure_of_enemy":false}: ["Investigate"],
}

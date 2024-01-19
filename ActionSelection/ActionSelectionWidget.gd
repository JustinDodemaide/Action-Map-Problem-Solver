extends VBoxContainer

const preset:PackedStringArray = ["UnarmedAttack","PickUpWeapon","Shoot","GetToCover","Investigate"]

func _ready():
	for i in preset:
		var option = preload("res://ActionSelection/ActionSelectionOption.tscn").instantiate()
		option.init(i)
		option.toggled.connect(toggled)
		add_child(option)

func toggled(option):
	var pool:PackedStringArray = ["Chill"]
	for action in get_children():
		if action.on:
			pool.append(action.action)
	AIActionMaps.make_action_map("Soldier",pool)
	# print(AIActionMaps.action_maps["Soldier"])

extends Node


var action_maps = {
	"Soldier":preload("res://ActionMaps/ActionMap_Default.gd").new().action_map
}

func make_action_map(map_name:String,action_pool:PackedStringArray)->void:
	var map:Dictionary
	for string in action_pool:
		var action = load("res://Actions/" + string + ".gd").new()
		var effects = action.get_effects()
		for key in effects:
			var dict = {key: effects[key]}
			if not map.has(dict):
				map[dict] = []
			map[dict].append(string)
	action_maps[map_name] = map
	pass

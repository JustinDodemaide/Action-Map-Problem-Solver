extends Node

var states = {
	"chill":false,
	"unsure_of_enemy":false,
	"has_enemy":false,
	"enemy_near":false,
	"has_weapon":false,
	"covered":false,
}

func _ready():
	$Agent.character = self
	for key in states:
		var new_debug = preload("res://StateDebugger/state_debugger.tscn").instantiate()
		new_debug.init(self,key,states[key])
		$States.add_child(new_debug)
	
func _on_agent_plan_updated(queue):
	$Plan.text = "Plan:\n" + str(queue)

func change_state(state:String, value:bool):
	states[state] = value
	$States.get_node(state).change_toggle(value)

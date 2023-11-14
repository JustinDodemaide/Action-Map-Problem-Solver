extends Panel

@export var action:String
var on:bool = false
signal toggled(action)

func init(a:String):
	action = a
	$HBoxContainer/Label.text = a

func _process(delta):
	size = $HBoxContainer.size

func _on_button_pressed():
	on = $HBoxContainer/Button.button_pressed
	emit_signal("toggled",self)

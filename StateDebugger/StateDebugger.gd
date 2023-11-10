extends HBoxContainer

var character

func init(char, state:String,toggle:bool):
	character = char
	$Label.text = state
	$CheckBox.button_pressed = toggle


func _on_check_box_pressed():
	character.states[$Label.text] = $CheckBox.button_pressed

extends Camera2D

var move_speed = 1000

func _process(delta):
	return
	if Input.is_action_pressed("A"):
		global_position += Vector2.LEFT * delta * move_speed
	elif Input.is_action_pressed("D"):
		global_position += Vector2.RIGHT * delta * move_speed

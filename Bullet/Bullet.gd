extends Node2D

var velocity = Vector2(20,0)

func _physics_process(delta):
	position += velocity * delta

func _on_timer_timeout():
	queue_free()


func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		pass
	if parent is Character:
		pass
	
	return
	if area.get_parent().has_method("damage"):
		area.get_parent().damage(20)

func damage(_amount):
	print("bullet hit bullet")
	queue_free()

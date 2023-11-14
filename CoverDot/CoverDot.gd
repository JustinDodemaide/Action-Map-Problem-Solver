extends Sprite2D

func _ready():
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(255,255,255,0),1)

func _on_timer_timeout():
	queue_free()

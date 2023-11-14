extends TileMap

func _ready():
	Global.level = self

func is_position_traversable(pos:Vector2i)->bool:
	var tile = local_to_map(pos)
	return true

func _process(_delta):
	$FPS.text = str(Engine.get_frames_per_second())

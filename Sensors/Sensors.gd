extends Node2D

@export var debug:bool = false
@export var sight_radius:int = 1
@export var hearing_radius:int = 1

signal character_seen(character)
signal flanked(character)
signal sound_heard(sound)

func _ready():
	$SightArea.scale = Vector2(sight_radius,sight_radius)
	#$HearingArea.scale = Vector2(hearing_radius,hearing_radius)
	if debug:
		$Sees.visible = true

func _process(delta):
	#$Sees.text = "Sees: "
	for i in $SightArea.get_overlapping_areas():
		#print(i)
		$SightLine.target_position = i.global_position - $SightLine.global_position
		if $SightLine.is_colliding():
			#print("raycast colliding with ", $RayCast2D.get_collider().name)
			#print("raycast cant see ", i.name)
			continue
		if i.get_parent() is Character or i.get_parent() is PlayerCharacter:
			emit_signal("character_seen",i.get_parent())

			$CoverLine.target_position = i.global_position - $CoverLine.global_position
			if not $CoverLine.is_colliding():
				emit_signal("flanked",i.get_parent())
		#$Sees.text += i.name + "\n"
		#print(get_parent, " sees ", i)

func _on_hearing_area_entered(area):
		emit_signal("sound_heard",area)

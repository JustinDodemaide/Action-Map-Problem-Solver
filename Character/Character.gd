extends CharacterBody2D
class_name Character

@export var sprite_color:String

var moving:bool = false

var target
var last_seen_location:Vector2 = Vector2(-1,-1)

var action_pool:PackedStringArray = []

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
		$VBoxContainer/States.add_child(new_debug)
		
	$AnimatedSprite2D.sprite_frames = load("res://Character/" + sprite_color + ".tres")

func _on_agent_plan_updated(queue):
	$VBoxContainer/Plan.text = "Plan:\n" + str(queue)

func change_state(state:String, value:bool):
	states[state] = value
	$VBoxContainer/States.get_node(state).change_toggle(value)

var ready_to_shoot:bool = true
func shoot():
	if not ready_to_shoot:
		return
	var spawned_bullet = preload("res://Bullet/Bullet.tscn").instantiate()
	var rot = get_angle_to(last_seen_location)
	spawned_bullet.rotation = rot
	spawned_bullet.position = position
	spawned_bullet.velocity = spawned_bullet.velocity.rotated(rot) * Vector2(100,100)
	Global.level.add_child(spawned_bullet)
	ready_to_shoot = false
	
	var tween = Global.create_tween()
	tween.tween_interval(0.5)
	await tween.finished
	ready_to_shoot = true

func _input(event):
	pass

func move_to(pos:Vector2):
	# print("target position: ", pos)
	moving = true
	$AnimatedSprite2D.play("move")
	$NavigationAgent2D.set_target_position(pos)

func _physics_process(_delta: float) -> void:
	if moving:
		move($NavigationAgent2D.get_next_path_position())

func move(destination):
	#print("moving to: ", destination)
	if destination.x < position.x:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	velocity = (destination - position).normalized() * 180
	move_and_slide()

func _on_navigation_agent_2d_target_reached():
	moving = false
	$AnimatedSprite2D.play("idle")
	# print("target reached")

func _on_sensors_flanked(character):
	#print("flanked by ", character.name)
	change_state("covered", false)

func _on_sensors_character_seen(character):
	if character is PlayerCharacter:
		#print("sees player character")
		target = character
		last_seen_location = character.position
		$InvestigationTimer.stop()
		$InvestigationTimer.start(2.5)
		change_state("unsure_of_enemy",false)
		change_state("has_enemy",true)

func _on_investigation_timer_timeout():
	# print("investigation timer")
	target = null
	change_state("has_enemy",false)
	change_state("unsure_of_enemy",true)

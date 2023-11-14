extends CharacterBody2D
class_name PlayerCharacter

var speed = 200

var holding_left_mouse:bool = false

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("LeftMouse"):
		holding_left_mouse = true
		#equipped.primary()
	if event.is_action_released("LeftMouse"):
		holding_left_mouse = false

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('D'):
		$AnimatedSprite2D.flip_h = false
		velocity.x += 1
	if Input.is_action_pressed('A'):
		$AnimatedSprite2D.flip_h = true
		velocity.x -= 1
	if Input.is_action_pressed('S'):
		velocity.y += 1
	if Input.is_action_pressed('W'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	if velocity != Vector2.ZERO:
		$AnimatedSprite2D.play("move")
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()

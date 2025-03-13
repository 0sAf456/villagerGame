extends CharacterBody2D

@export
var Max_Speed = 80
@export
var Acceleration = 20
@export
var Friction = 30
var mouse_position

@onready var player_animation = $AnimatedSprite2D
@onready var rotator_object = $ObjectRotator
@onready var weapon_object = $ObjectRotator/Weapon
func _physics_process(delta):
	get_input()
	move_and_slide()
	
	print("X: ", velocity.x, " | Y: ", velocity.y, " | Velocity length: ", velocity.length())
	if velocity.length() == 0:
		player_animation.play("idle")
	if velocity.x > 1:
		player_animation.flip_h = false
		player_animation.play("run")
	if velocity.x < -1:
		player_animation.flip_h = true
		player_animation.play("run")

func _process(delta):
	rotator_object.look_at(get_global_mouse_position())

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	velocity.y = move_toward(velocity.y, input_direction.y * Max_Speed, Acceleration)
	velocity.x = move_toward(velocity.x, input_direction.x * Max_Speed, Acceleration)
	

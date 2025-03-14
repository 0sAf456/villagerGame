extends CharacterBody2D

@export
var Max_Speed = 60
@export
var Acceleration = 20
var Health = 10
var mouse_position

@onready var player_animation = $AnimatedSprite2D
@onready var player_hitbox = $CollisionShape2D
@onready var weapon = $Weapon

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	print("X: ", velocity.x, " | Y: ", velocity.y, " | Velocity length: ", velocity.length())
	if velocity.length() == 0:
		player_animation.play("idle")
	if velocity.x > 1:
		player_animation.flip_h = false #flips player sprite to the right
		weapon.position.x = abs(weapon.position.x) #flips weapon sprite when facing right
		player_hitbox.position.x = -abs(player_hitbox.position.x) #flips hitbox right
		player_animation.play("run")
	if velocity.x < -1:
		player_animation.flip_h = true #flips player sprite to the left
		weapon.position.x = -abs(weapon.position.x) #flips weapon sprite when facing left
		player_hitbox.position.x = abs(player_hitbox.position.x) #flips hitbox left
		player_animation.play("run")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	velocity.y = move_toward(velocity.y, input_direction.y * Max_Speed, Acceleration)
	velocity.x = move_toward(velocity.x, input_direction.x * Max_Speed, Acceleration)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		weapon.attack()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.name == "hitBox":
		print_debug(area.get_parent().name)

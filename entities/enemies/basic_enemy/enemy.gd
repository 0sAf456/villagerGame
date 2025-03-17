extends CharacterBody2D

@export var speed = 15
var chasing = false
var player = null
var health = 30

@onready var raycast2D = $detection_area/RayCast2D


func _physics_process(delta: float) -> void:
	if chasing:
		if player != null:
			# Move towards the player
			var direction: Vector2 = (player.position - position).normalized()
			velocity = direction * speed
			

			# Update the RayCast2D direction to point towards the player
			raycast2D.target_position = direction * 50  # Adjust the multiplier as needed

			# Check if the raycast is colliding with something
			if raycast2D.is_colliding():
				var collider: Object = raycast2D.get_collider()
				if collider == player:
					# Do something if the raycast hits the player
					move_and_slide()
		
		

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	chasing = true
			
			
	

func handle_hit(damage: int):
	health -= damage
	print("enemy was hit, current health: " + str(health))
	if health < 0:
		queue_free()
	print("Enemy was hit")

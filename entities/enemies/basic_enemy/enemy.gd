extends CharacterBody2D

@export var speed = 15
var chasing = false
var player = null
var health = 30

@onready var raycast2D = $detection_area/RayCast2D


func _physics_process(delta: float) -> void:
	if chasing && player!= null	:
			# Move towards the player
			var direction: Vector2 = (player.position - position)
			raycast2D.target_position = direction
			
			if raycast2D.is_colliding():
				var collider: Object = raycast2D.get_collider()
				if collider == player:
					
					if direction.length() > 10:
						direction = direction.normalized()
						velocity = direction * speed
						
					else :
						direction = -(direction.normalized())
						velocity = Vector2.ZERO
						
					var collision = move_and_collide(delta * velocity)
					if collision:
						velocity = Vector2.ZERO					
		
		

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	chasing = true
func handle_hit(damage: int):
	health -= damage
	print("enemy was hit, current health: " + str(health))
	if health < 0:
		queue_free()
	print("Enemy was hit")

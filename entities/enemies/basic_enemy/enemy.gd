extends CharacterBody2D
@export var speed = 15
var chasing = false
var player = null

func _physics_process(delta: float) -> void:
	if chasing:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		#position += (player.position - position) / speed
		
		
		

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	chasing = true

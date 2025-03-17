extends Area2D

var damage: = 10

@onready var animation = $AnimationPlayer
func attack():
	animation.play("swing")
	
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("handle_hit"):
		body.handle_hit()

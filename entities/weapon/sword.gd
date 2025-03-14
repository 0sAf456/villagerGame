extends Area2D


@onready var animation = $AnimationPlayer
func attack():
	animation.play("swing")

class_name Respawn extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.is_jumping = true
	character.torso_animation.play("jump")
	character.legs_animation.play("not_running_legs")

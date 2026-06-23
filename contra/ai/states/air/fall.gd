class_name Fall extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.is_jumping = false
	character.torso_animation.play("fall")
	character.legs_animation.play("not_running_legs")

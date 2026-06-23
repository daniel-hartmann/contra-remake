class_name Jump extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.velocity.y = character.JUMP_VELOCITY
	character.is_jumping = true
	character.torso_animation.play("jump")
	character.legs_animation.play("not_running_legs")

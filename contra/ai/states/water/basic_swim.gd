class_name BasicSwim extends State

@onready var character := owner as CharacterBody2D
@export var collision_shape: Shape2D

func enter() -> void:
	character.torso_animation.play("water")
	character.legs_animation.play("not_running_legs")

func physics_update(delta: float) -> void:
	pass

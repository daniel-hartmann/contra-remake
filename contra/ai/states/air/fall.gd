class_name Fall extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.is_jumping = false
	character.animated_sprite.play("fall")

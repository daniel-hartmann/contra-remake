class_name Dying extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("dying")

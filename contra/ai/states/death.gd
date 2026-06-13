class_name Death extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.velocity = Vector2.ZERO
	enter_child("dying")

class_name Death extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	enter_child("dying")

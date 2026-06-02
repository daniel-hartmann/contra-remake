class_name Water extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	enter_child("swim")

func _shared_physics(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
		return

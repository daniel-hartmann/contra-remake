class_name GroundedState extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	enter_child("idle")  # default child

func _shared_physics(delta: float) -> void:
	if character.is_on_water:
		if character.torso_animation.animation != "water_in":
			transitioned.emit(self, "water")
		return

	if not character.is_on_floor():
		transitioned.emit(self, "air")

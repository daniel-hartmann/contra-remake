class_name Dive extends State

@onready var character := owner as CharacterBody2D
@export var collision_shape: Shape2D

func enter() -> void:
	character.velocity.x = 0
	character.torso_animation.play("water_dive")
	character.legs_animation.play("not_running_legs")
	character.hitbox_shape.shape = collision_shape

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if not Input.is_action_pressed("down") or direction:
		transitioned.emit(self, "swim")
		return

class_name Dive extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.velocity.x = 0
	character.animated_sprite.play("water_dive")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if not Input.is_action_pressed("down") or direction:
		transitioned.emit(self, "swim")
		return

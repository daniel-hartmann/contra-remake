class_name Fall extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.is_jumping = false
	character.animated_sprite.play("fall")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if direction:
		character.velocity.x = direction * character.SPEED
		character.animated_sprite.flip_h = direction < 0
	else:
		character.velocity.x = move_toward(
			character.velocity.x,
			0,
			character.SPEED
		)

	if character.is_on_floor():
		if direction:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")

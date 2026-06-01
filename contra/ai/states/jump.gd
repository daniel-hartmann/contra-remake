class_name Jump extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.velocity.y = character.JUMP_VELOCITY
	character.is_jumping = true
	character.animated_sprite.play("jump")

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
		transitioned.emit(self, "idle")
		return

class_name Air extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	if Input.is_action_just_pressed("jump"):
		enter_child("jump")
	else:
		enter_child("fall")

func _shared_physics(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
		return

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
		if character.is_on_water:
			transitioned.emit(self, "water")
		else:
			transitioned.emit(self, "ground")

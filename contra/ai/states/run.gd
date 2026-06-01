class_name Run extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("run")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if not character.is_on_floor():
		transitioned.emit(self, "fall")
		return

	if Input.is_action_pressed("down") and direction == 0:
		transitioned.emit(self, "crouch")
		return

	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
		return

	if direction == 0:
		transitioned.emit(self, "idle")
		return

	character.velocity.x = direction * character.SPEED
	character.animated_sprite.flip_h = direction < 0

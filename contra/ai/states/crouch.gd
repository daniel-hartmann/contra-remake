class_name Crouch extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.velocity.x = 0
	character.animated_sprite.play("crouch")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if not character.is_on_floor():
		transitioned.emit(self, "fall")
		return

	if direction != 0:
		transitioned.emit(self, "run")
		return

	if not Input.is_action_pressed("down"):
		transitioned.emit(self, "idle")
		return

	if Input.is_action_just_pressed("jump"):
		character.set_collision_mask_value(1, false)
		character.is_jumping = false
		character.get_node("DropTimer").start()
		transitioned.emit(self, "fall")
		return

	character.velocity.x = 0

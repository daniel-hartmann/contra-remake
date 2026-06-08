class_name AimUp extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.is_jumping = false
	character.animated_sprite.play("aim_up")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)

	if not character.is_on_floor():
		transitioned.emit(self, "fall")
		return

	if Input.is_action_pressed("down"):
		transitioned.emit(self, "crouch")
		return

	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "air")
		return

	if direction != 0:
		transitioned.emit(self, "run")
		return
		
	if !Input.is_action_pressed("up"):
		transitioned.emit(self, "idle")

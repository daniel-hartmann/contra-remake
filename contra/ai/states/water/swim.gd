class_name Swim extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("water_in")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if Input.is_action_pressed("down") and direction == 0:
		transitioned.emit(self, "dive")
		return

	if direction == 0:
		character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)
		return

	character.velocity.x = direction * character.SPEED
	
	if character.is_climbing:
		character.velocity.x = 0
	
	character.animated_sprite.flip_h = direction < 0

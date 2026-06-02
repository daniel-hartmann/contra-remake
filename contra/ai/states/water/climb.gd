class_name Climb extends State

const CLIMB_SPEED := -80.0   # upward velocity while climbing out
const CLIMB_HEIGHT := 16.0   # how many pixels upward to travel before landing

@onready var character := owner as CharacterBody2D

var target_y: float = 0.0

func enter() -> void:
	character.animated_sprite.play("water_out")
	character.velocity.x = 0
	character.velocity.y = CLIMB_SPEED
	target_y = character.position.y - CLIMB_HEIGHT

func physics_update(delta: float) -> void:
	if character.position.y <= target_y:
		character.position.y = target_y
		character.velocity.y = 0
		character.is_on_water = false
		transitioned.emit(self, "ground")
		return

	character.velocity.y = CLIMB_SPEED
 

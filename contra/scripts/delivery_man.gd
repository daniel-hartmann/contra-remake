class_name Enemy extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -230.0

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() / 2 * delta

	move_and_slide()

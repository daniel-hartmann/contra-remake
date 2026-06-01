extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -230.0

var is_jumping := false

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() / 2 * delta

	move_and_slide()


func _on_drop_timer_timeout() -> void:
	set_collision_mask_value(1, true)

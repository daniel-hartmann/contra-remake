extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -230.0

var is_jumping := false

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() / 2 * delta

	var direction := Input.get_axis("left", "right")

	var is_crouching := (
		Input.is_action_pressed("down")
		and direction == 0
		and is_on_floor()
	)

	# Horizontal movement
	if is_crouching:
		velocity.x = 0
	else:
		if direction:
			velocity.x = direction * SPEED
			animated_sprite.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Drop through platform
	if is_crouching:
		animated_sprite.play("crouch")

		if Input.is_action_just_pressed("jump"):
			set_collision_mask_value(1, false)
			is_jumping = false
			$DropTimer.start()

	# Normal jump
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		animated_sprite.play("jump")

	# Air animations
	elif not is_on_floor():
		if is_jumping:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

	# Ground animations
	else:
		is_jumping = false

		if direction:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")

	move_and_slide()


func _on_drop_timer_timeout() -> void:
	set_collision_mask_value(1, true)

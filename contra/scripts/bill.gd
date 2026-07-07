extends CharacterBody2D
class_name Player

const SPEED = 60.0
const JUMP_VELOCITY = -230.0

var god_mode := false
var blinking_flag := false

var is_jumping := false
var is_on_water := false
var is_climbing := false
var is_dead := false
var is_firing := false

var _cheat_buffer := ""

signal bullet_fired

@onready var torso_animation = $TorsoAnimation
@onready var legs_animation = $LegsAnimation
@onready var hitbox_shape = $Hitbox/CollisionShape2D
@onready var weapon_cooldown = $WeaponCooldown
@onready var fsm = $FSM

var blink_accumulator: float = 0.0
const BLINK_SPEED: float = 0.02

const BULLET = preload("res://scenes/Bullet.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor() and not is_on_water:
		velocity += get_gravity() / 2 * delta

	if god_mode:
		blink_accumulator += delta
		if blink_accumulator >= BLINK_SPEED:
			blink_accumulator = 0.0 # Reset time tracking
			blinking_flag = !blinking_flag

			var target_color = Color(1, 1, 1, 0.6) if blinking_flag else Color.WHITE
			torso_animation.modulate = target_color
			legs_animation.modulate = target_color
	else:
		if torso_animation.modulate != Color.WHITE:
			torso_animation.modulate = Color.WHITE
			legs_animation.modulate = Color.WHITE
			blink_accumulator = 0.0

	move_and_slide()


func toggle_hitbox_collisions(collide: bool) -> void:
	$Hitbox/CollisionShape2D.set_deferred("disabled", !collide)


func _on_drop_timer_timeout() -> void:
	set_collision_mask_value(1, true)

func _on_back_to_the_ground_body_entered(body: Node2D) -> void:
	if body.name == "Bill" and is_on_water:
		is_on_water = false
		torso_animation.play("water_out")
		legs_animation.play("not_running_legs")
		is_climbing = true
		$BackToGroundTimer.start()

func _on_back_to_ground_timer_timeout() -> void:
	is_on_water = false
	is_climbing = false
	global_position.y -= 16
	fsm.on_child_transition(fsm.current_state, "ground")


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot()
		weapon_cooldown.start(.4)
		is_firing = true

	if event is InputEventKey and event.pressed and not event.echo:
		var key_char = OS.get_keycode_string(event.physical_keycode).to_lower()
		if key_char.length() == 1:
			_cheat_buffer += key_char
			# keep buffer trimmed so it doesn't grow forever
			if _cheat_buffer.length() > 20:
				_cheat_buffer = _cheat_buffer.substr(_cheat_buffer.length() - 20)

			if _cheat_buffer.right(5) == "iddqd":
				Log.debug("GOD MODE ENABLED")
				toggle_god_mode(true)


func toggle_god_mode(value: bool) -> void:
	god_mode = value
	toggle_hitbox_collisions(!value)
	set_collision_layer_value(10, value)


func shoot():
	bullet_fired.emit()
	# 1. Create an instance of the bullet
	var b = BULLET.instantiate()
	# 2. Set the bullet's position and rotation
	b.global_position = $Mira.global_position
	
	if fsm.current_state.name == "Water":
		if fsm.current_state.current_state.name == "Dive":
			b.queue_free()
			return
			
	var direction := Input.get_axis("left", "right")
	
	if fsm.current_state.name == "Ground":
		if fsm.current_state.current_state.name == "Run":
			if fsm.current_state.current_state.current_state.name == "RunAimHigh":
				b.global_rotation_degrees = -40
			elif fsm.current_state.current_state.current_state.name == "RunAimLow":
				b.global_rotation_degrees = 40
		elif fsm.current_state.current_state.name == "AimUp":
			b.global_rotation_degrees = -90
	elif fsm.current_state.name == "Water":
		if fsm.current_state.current_state.name == "Swim":
			if fsm.current_state.current_state.current_state.name == "WaterAimHigh":
					b.global_rotation_degrees = -40
			elif fsm.current_state.current_state.current_state.name == "WaterAimUp":
				b.global_rotation_degrees = -90
			
	if torso_animation.flip_h:
		b.global_rotation_degrees = 180 - b.global_rotation_degrees

	# 3. Add it to the main scene (instead of the player, so it doesn't move with the player)
	get_parent().add_child(b)

func respawn() -> void:
	reset()
	global_position = Utils.get_camera_top_left() + Vector2(48, 10)

	# set respawn state
	fsm.on_child_transition(fsm.current_state, "air")
	fsm.current_state.enter_child("respawn")
	
	# set temporarily as invincible
	toggle_god_mode(true)
	$RespawnTimer.start()

func reset() -> void:
	is_jumping = false
	is_on_water = false
	is_climbing = false
	is_dead = false
	is_firing = false
	toggle_hitbox_collisions(true)

func die() -> void:
	# Avoid triggering reset and state transitioning more than one time
	if is_dead:
		return

	reset()
	fsm.on_child_transition(fsm.current_state, "death")
	is_dead = true
	toggle_hitbox_collisions(false)

func firing() -> bool:
	return is_firing

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy and not body.is_dead:
		die()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is DeathArea or area is Bullet:
		die()

func _on_weapon_cooldown_timeout() -> void:
	is_firing = false


func _on_respawn_timer_timeout() -> void:
	toggle_god_mode(false)

extends CharacterBody2D
class_name Player

const SPEED = 60.0
const JUMP_VELOCITY = -230.0

var is_jumping := false
var is_on_water := false
var is_climbing := false
var is_dead := false
var is_firing := false

signal bullet_fired

@onready var torso_animation = $TorsoAnimation
@onready var legs_animation = $LegsAnimation
@onready var hitbox_shape = $Hitbox/CollisionShape2D
@onready var weapon_cooldown = $WeaponCooldown
@onready var fsm = $FSM

const BULLET = preload("res://scenes/Bullet.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor() and not is_on_water:
		velocity += get_gravity() / 2 * delta

	move_and_slide()

func _on_drop_timer_timeout() -> void:
	set_collision_mask_value(1, true)

func _on_back_to_the_ground_body_entered(body: Node2D) -> void:
	if body.name == "Bill" and is_on_water:
		print("_on_back_to_the_ground_body_entered")
		is_on_water = false
		torso_animation.play("water_out")
		legs_animation.play("not_running_legs")
		is_climbing = true
		$BackToGroundTimer.start()
		#$FSM.current_state.enter_child("climb")

func _on_back_to_ground_timer_timeout() -> void:
	print("_on_back_to_ground_timer_timeout")
	is_on_water = false
	is_climbing = false
	global_position.y -= 16
	fsm.on_child_transition(fsm.current_state, "ground")
	
func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot()
		weapon_cooldown.start(.4)
		is_firing = true

func shoot():
	bullet_fired.emit()
	# 1. Create an instance of the bullet
	var b = BULLET.instantiate()
	# 2. Set the bullet's position and rotation
	b.global_position = $Mira.global_position
	
	if fsm.current_state.name == "Ground":
		if fsm.current_state.current_state.name == "Run":
			if fsm.current_state.current_state.current_state.name == "RunAimHigh":
				b.global_rotation_degrees = -40
			elif fsm.current_state.current_state.current_state.name == "RunAimLow":
				b.global_rotation_degrees = 40
		elif fsm.current_state.current_state.name == "AimUp":
			b.global_rotation_degrees = -90
			
	if torso_animation.flip_h:
		b.global_rotation_degrees = 180 - b.global_rotation_degrees

	# 3. Add it to the main scene (instead of the player, so it doesn't move with the player)
	get_parent().add_child(b)

func reset() -> void:
	is_jumping = false
	is_on_water = false
	is_climbing = false
	is_dead = false
	is_firing = false

func die() -> void:
	# Avoid triggering reset and state transitioning more than one time
	if is_dead:
		return

	reset()
	fsm.on_child_transition(fsm.current_state, "death")
	is_dead = true

func firing() -> bool:
	return is_firing

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy and not body.is_dead:
		die()

func _on_hitbox_area_entered(area: Area2D) -> void:
	print(area)
	if area is DeathArea:
		print("DeathArea")
		die()

func _on_weapon_cooldown_timeout() -> void:
	is_firing = false

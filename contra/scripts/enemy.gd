class_name Enemy extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -230.0
const BULLET = preload("res://scenes/Bullet.tscn")
const BULLET_SPEED = 80

@onready var animated_sprite = $AnimatedSprite2D

var is_dead: bool = true
var is_firing := false
var current_bullets: Array[Bullet]

@export var disabled: bool = false # used for testing with less enemies
@export var max_bullets: int = 0
@export var player: Player
@export var weapon_cooldown: Timer



func _ready() -> void:
	reset()


func toggle_collisions(collide: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", !collide)
	$Hitbox/CollisionShape2D.set_deferred("disabled", !collide)


func reset() -> void:
	$FSM.set_physics_process(false)
	if $FSM.current_state:
		$FSM.current_state.enter_child($FSM.current_state.initial_state.name)
	set_physics_process(false)
	toggle_collisions(false)
	is_dead = true
	global_position = Vector2(-100, -100)
	current_bullets = []
	is_firing = false
	hide()


func spawn():
	$FSM.set_physics_process(true)
	if $FSM.current_state:
		$FSM.current_state.enter_child($FSM.current_state.initial_state.name)
	set_physics_process(true)
	toggle_collisions(true)
	is_dead = false
	show()


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() / 2 * delta

	if len(current_bullets) < max_bullets:
		shoot()

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Bullet:
		is_dead = true
		# TODO: use the bullet.die or something that will be created
		area.queue_free()


func shoot() -> void:
	if is_firing:
		return

	var bullet = BULLET.instantiate()
	bullet.speed = BULLET_SPEED
	bullet.collision_layer = 9

	var direction_to_player = (player.global_position - global_position).normalized()

	# Enemies have 30 degree snapping in their aims
	# Convert current direction angle to degrees
	var angle_deg = rad_to_deg(direction_to_player.angle())
	# Snap the angle to the nearest 30 degrees
	var snapped_angle_deg = snapped(angle_deg, 30)
	# Convert back to radians
	var snapped_angle_rad = deg_to_rad(snapped_angle_deg)
	# Update the direction vector to match the snapped angle
	direction_to_player = Vector2.RIGHT.rotated(snapped_angle_rad)

	# flip
	#$AnimatedSprite2D.flip_h = direction_to_player.x < 0
	var facing_right = direction_to_player.x >= 0
	$AnimatedSprite2D.flip_h = !facing_right

	# aim state based on vertical component
	if direction_to_player.y < -0.4:
		$FSM.current_state.enter_child("enemyaimhigh")
	elif direction_to_player.y > 0.4:
		$FSM.current_state.enter_child("enemyaimlow")
	else:
		$FSM.current_state.enter_child("enemyaimmid")

	var muzzle: Marker2D
	if $FSM.current_state.current_state is EnemyAimHigh:
		muzzle = $AimHigh
	elif $FSM.current_state.current_state is EnemyAimLow:
		muzzle = $AimLow
	else:
		muzzle = $AimMid

	muzzle.position.x = abs(muzzle.position.x) * (1 if facing_right else -1)
	bullet.global_position = muzzle.global_position

	bullet.global_rotation = direction_to_player.angle()
	#if $AnimatedSprite2D.flip_h:
		#bullet.global_rotation_degrees = 90 - bullet.global_rotation_degrees

	# Add it to the main scene (instead of the player, so it doesn't move with the player)
	get_parent().add_child(bullet)
	
	current_bullets.append(bullet)
	bullet.tree_exiting.connect(func(): current_bullets.erase(bullet))

	is_firing = true
	weapon_cooldown.start(.5)


func _on_weapon_cooldown_timeout() -> void:
	is_firing = false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Resetting enemy off screen")
	reset()

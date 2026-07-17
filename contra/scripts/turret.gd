class_name Turret extends Area2D


const BULLET = preload("res://scenes/Bullet.tscn")
const BULLET_SPEED = 60

@onready var animated_sprite = $AnimatedSprite2D
@onready var weapon_cooldown = $WeaponCooldownTimer

var is_firing := false
var is_aiming := false
var current_bullets: Array[Bullet]
var on_screen := false
var current_direction := Vector2.LEFT
var current_muzzle: Marker2D

@export var max_bullets: int = 2
@export var player: Player
@export var life: float = 8


func toggle_collisions(collide: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", !collide)


func _physics_process(delta: float) -> void:
	if not is_aiming or not player:
		return

	_update_aim()

	if len(current_bullets) < max_bullets:
		shoot()


func _update_aim() -> void:
	var direction_to_player = (player.global_position - global_position).normalized()
	var angle_deg = rad_to_deg(direction_to_player.angle())
	var snapped_angle_deg = snapped(angle_deg, 30)
	var bucket_label = int(fposmod(-snapped_angle_deg, 360))

	current_direction = Vector2.RIGHT.rotated(deg_to_rad(snapped_angle_deg))
	current_muzzle = get_node("Aim%03d" % bucket_label)

	var anim_name = "aim_%03d" % bucket_label
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		life -= PlayerStats.current_gun.DAMAGE
		area.queue_free()


func shoot() -> void:
	if is_firing:
		return

	var bullet = BULLET.instantiate()
	bullet.speed = BULLET_SPEED
	bullet.collision_layer = 9

	bullet.global_position = current_muzzle.global_position
	bullet.global_rotation = current_direction.angle()

	# Add it to the main scene (instead of the player, so it doesn't move with the player)
	get_parent().add_child(bullet)

	current_bullets.append(bullet)
	bullet.tree_exiting.connect(func(): current_bullets.erase(bullet))

	is_firing = true
	weapon_cooldown.start()


func _on_weapon_cooldown_timeout() -> void:
	is_firing = false


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	on_screen = true

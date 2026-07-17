extends AnimatedSprite2D

@export var BULLET: PackedScene
@export var player: Player
@export var detection_range: float = 150.0

@onready var reload: Timer = $RayCast2D/timer
@onready var raycast: RayCast2D = $RayCast2D
@onready var hurtbox: Area2D = $damage_box

const MAX_HITS: int = 4
var current_hits: int = 0
var can_shoot := true


func _ready() -> void:
	stop()
	animation_finished.connect(_on_animation_finished)
	reload.timeout.connect(_on_reload_timeout)
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)
	reload.one_shot = true
	reload.wait_time = 1.9


func _physics_process(_delta: float) -> void:
	if can_shoot and player and player_in_range():
		shoot()


func player_in_range() -> bool:
	return global_position.distance_to(player.global_position) <= detection_range


func shoot() -> void:
	can_shoot = false
	reload.start()

	play("shoot")

	if BULLET:
		var bullet = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position

		# Direção baseada na seta do RayCast2D, não no player
		var shoot_direction: Vector2 = raycast.global_transform.basis_xform(raycast.target_position).normalized()
		bullet.global_rotation = shoot_direction.angle()

		if bullet.has_method("launch"):
			bullet.launch()


func _on_reload_timeout() -> void:
	can_shoot = true


func _on_animation_finished() -> void:
	stop()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Bullet:
		take_damage()
		area.queue_free()


func take_damage() -> void:
	current_hits += 1
	print("Torreta levou tiro! Hits: ", current_hits, "/", MAX_HITS)
	if current_hits >= MAX_HITS:
		die()


func die() -> void:
	print("Torreta destruída!")
	queue_free()

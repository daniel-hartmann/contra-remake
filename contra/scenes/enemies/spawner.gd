extends Marker2D

@export var pool: EnemyPool
var spawned: bool = false


func _process(delta: float) -> void:
	var camera_bounds = Utils.get_camera_bounds()

	if camera_bounds.has_point(global_position) and not spawned:
		spawn()


func spawn() -> void:
	var enemy = pool.get_available()

	if enemy == null:
		return

	enemy.global_position = global_position
	enemy.spawn()
	spawned = true

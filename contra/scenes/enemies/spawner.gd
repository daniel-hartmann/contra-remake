extends Marker2D

@export var pool: EnemyPool
var spawned: bool = false


func _process(delta: float) -> void:
	var camera_bounds = get_camera_bounds()

	if camera_bounds.has_point(global_position) and not spawned:
		spawn()


func spawn() -> void:
	var enemy = pool.get_available()

	if enemy == null:
		return

	enemy.global_position = global_position
	enemy.spawn()
	spawned = true


func get_camera_bounds() -> Rect2:
	var camera = get_viewport().get_camera_2d()
	var center = camera.get_screen_center_position()
	var viewport_size = camera.get_viewport_rect().size
	var visible_size = viewport_size / camera.zoom
	var top_left = center - (visible_size / 2.0)
	return Rect2(top_left, visible_size)

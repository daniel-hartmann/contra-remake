extends Marker2D

@onready var pool = $"../../FlyingPowerUpPool"
var spawned: bool = false
var camera_has_passed: bool = false

func _process(delta: float) -> void:
	var camera_bounds = Utils.get_camera_bounds()
	
	if camera_bounds.has_point(global_position) and not camera_has_passed:
		camera_has_passed = true

	if !camera_bounds.has_point(global_position) and not spawned and camera_has_passed:
		spawn()


func spawn() -> void:
	var flying_power_up = pool.get_available()

	if flying_power_up == null:
		return

	flying_power_up.global_position = global_position
	flying_power_up.spawn()
	spawned = true

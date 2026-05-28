extends StaticBody2D

@export var camera: Camera2D
@export var offset_x: float = -128 + 16

func _physics_process(_delta: float) -> void:
	if camera:
		var camera_center = camera.get_screen_center_position()

		global_position.x = camera_center.x + offset_x
		global_position.y = camera_center.y

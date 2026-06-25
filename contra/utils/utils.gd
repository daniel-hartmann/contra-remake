extends Node


func get_camera_bounds() -> Rect2:
	var camera = get_viewport().get_camera_2d()
	var center = camera.get_screen_center_position()
	var viewport_size = camera.get_viewport_rect().size
	var visible_size = viewport_size / camera.zoom
	var top_left = center - (visible_size / 2.0)
	return Rect2(top_left, visible_size)


func get_camera_top_left() -> Vector2:
	var camera = get_viewport().get_camera_2d()
	# Get the center position (accounts for camera smoothing)
	var cam_center: Vector2 = camera.get_screen_center_position()

	# Get the size of the visible viewport area
	var viewport_size: Vector2 = camera.get_viewport_rect().size

	# Get the current zoom level (default is Vector2(1, 1))
	var cam_zoom: Vector2 = camera.zoom

	# Calculate the top-left corner
	return cam_center - (viewport_size / 2.0) / cam_zoom

extends Node

var console_scene := preload("res://utils/console_control.tscn").instantiate()
var console_is_opened := false
var console_tween: Tween


func _ready() -> void:
	Log.minimum_level = Log.Level.DEBUG

	change_screen(preload("res://scenes/game.tscn").instantiate())

	# Start hidden above the screen
	console_scene.position.y = get_window().size.y - 20
	add_child(console_scene)

func _physics_process(delta: float) -> void:
	# Make the console follow the camera
	var camera_bounds = get_camera_bounds()
	console_scene.global_position.x = camera_bounds.position.x
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_console"):
		toggle_console()


func get_camera_bounds() -> Rect2:
	var camera = get_viewport().get_camera_2d()
	var center = camera.get_screen_center_position()
	var viewport_size = camera.get_viewport_rect().size
	var visible_size = viewport_size / camera.zoom
	var top_left = center - (visible_size / 2.0)
	return Rect2(top_left, visible_size)


func toggle_console():
	console_is_opened = !console_is_opened

	if console_tween:
		console_tween.kill()

	console_tween = create_tween()

	if console_is_opened:
		console_tween.tween_property(console_scene, "position:y", 140, 0.25)
	else:
		console_tween.tween_property(console_scene, "position:y", get_window().size.y, 0.25)


func change_screen(scene):
	for child in get_children():
		if child != console_scene:
			child.queue_free()

	add_child(scene)

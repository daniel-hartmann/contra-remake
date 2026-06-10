extends Node

var console_scene := preload("res://utils/console_control.tscn").instantiate()
var console_is_opened := false


func _ready() -> void:
	Log.minimum_level = Log.Level.DEBUG

	change_screen(preload("res://scenes/game.tscn").instantiate())

	# Console starts hidden
	console_scene.hide()
	add_child(console_scene)

	

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
	if console_is_opened:
		console_scene.hide()
	else:
		console_scene.show()

	console_is_opened = !console_is_opened


func change_screen(scene):
	for child in get_children():
		if child != console_scene:
			child.queue_free()

	add_child(scene)

extends Node

var console_scene := preload("res://utils/console_control.tscn").instantiate()
var console_is_opened := false


func _ready() -> void:
	Log.minimum_level = Log.Level.DEBUG

	change_screen(preload("res://scenes/game.tscn").instantiate())
	#change_screen(preload("res://scenes/title.tscn").instantiate())

	# Console starts hidden
	console_scene.hide()
	add_child(console_scene)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_console"):
		toggle_console()


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

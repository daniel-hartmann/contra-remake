extends Control

@export var bgm: AudioStream
var continue_selected := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_background_music(bgm)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		var current_continue_index = %ContinueCursor.z_index
		%ContinueCursor.z_index = %EndCursor.z_index
		%EndCursor.z_index = current_continue_index
		continue_selected = !continue_selected

	if event.is_action_pressed("start"):
		PlayerStats.restart()
		if continue_selected:
			get_parent().change_screen(load("res://scenes/game.tscn").instantiate())

		else:
			get_parent().change_screen(load("res://scenes/title.tscn").instantiate())

		queue_free()


func _process(delta: float) -> void:
	# TODO: blink 
	pass

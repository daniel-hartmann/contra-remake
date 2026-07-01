extends Control


@onready var main_container := $MainContainer
var is_ready := false
var one_player_selected := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_key_input(event: InputEvent) -> void:
	if not is_ready:
		return

	if event.is_action_pressed("select"):
		var current_one_player_index = %OnePlayerCursor.z_index
		%OnePlayerCursor.z_index = %TwoPlayerCursor.z_index
		%TwoPlayerCursor.z_index = current_one_player_index
		one_player_selected = !one_player_selected

	if event.is_action_pressed("start"):
		get_parent().change_screen(preload("res://scenes/game.tscn").instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_ready:
		return

	if main_container.global_position.x != 0:
		main_container.global_position.x -= 1

	if main_container.global_position.x == 0:
		is_ready = true
		%OnePlayerCursor.z_index = 0

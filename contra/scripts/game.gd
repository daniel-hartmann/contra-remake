extends Node

@onready var hud := $HUD
@onready var game_over_timer := $GameOverTimer

func _ready() -> void:
	toggle_lives_visibility()
	PlayerStats.lives_changed.connect(toggle_lives_visibility)
	PlayerStats.game_over.connect(_on_player_stats_game_over)


func toggle_lives_visibility() -> void:
	# Three lives is 2 symbols in the HUD.
	var lives = hud.get_node("Lives").get_children()
	for i in range(lives.size()):
		if i < PlayerStats.current_lives - 1:
			lives[i].show()
		else:
			lives[i].hide()

func set_game_over_sign_visibility(show: bool) -> void:
	if show:
		hud.get_node("GameOver").show()
	else:
		hud.get_node("GameOver").hide()


func _on_player_stats_game_over() -> void:
	set_game_over_sign_visibility(true)
	game_over_timer.start()


func _on_game_over_timer_timeout() -> void:
	# open game over screen
	get_parent().change_screen(load("res://scenes/game_over.tscn").instantiate())
	queue_free()

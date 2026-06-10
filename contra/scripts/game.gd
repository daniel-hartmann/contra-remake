extends Node

@onready var hud := $HUD


func _ready() -> void:
	toggle_lives_visibility()
	PlayerStats.lives_changed.connect(toggle_lives_visibility)


func toggle_lives_visibility() -> void:
	# Three lives is 2 symbols in the HUD.
	var lives = hud.get_node("Lives").get_children()
	for i in range(lives.size()):
		if i < PlayerStats.current_lives - 1:
			lives[i].show()
		else:
			lives[i].hide()

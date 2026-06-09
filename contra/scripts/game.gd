extends Node

@onready var hud := $HUD

var player_lives = 3;


func _ready() -> void:
	# Three lives is 2 symbols in the HUD.
	var lives = hud.get_node("Lives").get_children()
	for i in range(0, player_lives - 1):
		lives[i].show()


func get_camera_bounds() -> Rect2:
	"""Code repeated on main.gd"""
	var camera = get_viewport().get_camera_2d()
	var center = camera.get_screen_center_position()
	var viewport_size = camera.get_viewport_rect().size
	var visible_size = viewport_size / camera.zoom
	var top_left = center - (visible_size / 2.0)
	return Rect2(top_left, visible_size)

func _physics_process(delta: float) -> void:
	# HUD should seem fixed related to the camera
	var camera_bounds = get_camera_bounds()
	hud.global_position.x = camera_bounds.position.x

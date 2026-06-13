extends StaticBody2D

@export var camera: Camera2D

var viewport_width: float
var viewport_height: float


func _ready() -> void:
	viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")

func _physics_process(_delta: float) -> void:
	if not camera:
		return
	
	var offset: float = 0.0

	offset = -(viewport_width / 2.0) + 8
		
	var camera_center = camera.get_screen_center_position()
	
	global_position.x = camera_center.x + offset
	global_position.y = camera_center.y

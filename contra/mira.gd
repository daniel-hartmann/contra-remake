extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = $"../AnimatedSprite2D".global_position.x
	global_position.y = $"../AnimatedSprite2D".global_position.y
	
	var is_facing_left = $"../AnimatedSprite2D".flip_h == true
	
	if $"../FSM".current_state.name == "Ground":
		if $"../FSM".current_state.current_state.name == "Run":
			if $"../FSM".current_state.current_state.current_state.name == "RunAimHigh":
				if !is_facing_left: global_position.x += 11 
				else: global_position.x -= 11
				global_position.y += -17
			elif $"../FSM".current_state.current_state.current_state.name == "RunAimLow":
				if !is_facing_left: global_position.x += 13
				else: global_position.x -= 13
				global_position.y += 3
			elif $"../FSM".current_state.current_state.current_state.name == "RunAimMid":
				if !is_facing_left: global_position.x += 17
				else: global_position.x -= 17
				global_position.y += -5
		elif $"../FSM".current_state.current_state.name == "AimUp":
			if !is_facing_left: global_position.x += 6 
			else: global_position.x -= 6
			global_position.y += -27
		elif $"../FSM".current_state.current_state.name == "Crouch":
			if !is_facing_left: global_position.x += 16
			else: global_position.x -= 16
			global_position.y += 9
		elif $"../FSM".current_state.current_state.name == "Idle":
			if !is_facing_left: global_position.x += 17
			else: global_position.x -= 17
			global_position.y += -5
	elif $"../FSM".current_state.name == "Air":
		global_position.x = $"..".global_position.x
		global_position.y = $"..".global_position.y
				

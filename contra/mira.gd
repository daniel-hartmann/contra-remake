extends Marker2D

@onready var character := owner as CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = character.torso_animation.global_position.x
	global_position.y = character.torso_animation.global_position.y
	
	var is_facing_left = character.torso_animation.flip_h == true
	
	if character.fsm.current_state.name == "Ground":
		if character.fsm.current_state.current_state.name == "Run":
			if character.fsm.current_state.current_state.current_state.name == "RunAimHigh":
				if !is_facing_left: global_position.x += 11 
				else: global_position.x -= 11
				global_position.y += -17
			elif character.fsm.current_state.current_state.current_state.name == "RunAimLow":
				if !is_facing_left: global_position.x += 13
				else: global_position.x -= 13
				global_position.y += 3
			elif character.fsm.current_state.current_state.current_state.name == "RunAimMid" or character.fsm.current_state.current_state.current_state.name == "RunNoAim":
				if !is_facing_left: global_position.x += 17
				else: global_position.x -= 17
				global_position.y += -5
		elif character.fsm.current_state.current_state.name == "AimUp":
			if !is_facing_left: global_position.x += 6 
			else: global_position.x -= 6
			global_position.y += -27
		elif character.fsm.current_state.current_state.name == "Crouch":
			if !is_facing_left: global_position.x += 16
			else: global_position.x -= 16
			global_position.y += 9
		elif character.fsm.current_state.current_state.name == "Idle":
			if !is_facing_left: global_position.x += 17
			else: global_position.x -= 17
			global_position.y += -5
	elif character.fsm.current_state.name == "Air":
		global_position.x = character.global_position.x
		global_position.y = character.global_position.y
	elif character.fsm.current_state.name == "Water":
		if character.fsm.current_state.current_state.name == "Swim":
			if character.fsm.current_state.current_state.current_state.name == "WaterAimMid":
				if !is_facing_left: global_position.x += 17
				else: global_position.x -= 17
				global_position.y += -2
			elif character.fsm.current_state.current_state.current_state.name == "WaterAimHigh":
				if !is_facing_left: global_position.x += 11
				else: global_position.x -= 11
				global_position.y += -14
			elif character.fsm.current_state.current_state.current_state.name == "WaterAimUp":
				if !is_facing_left: global_position.x += 6
				else: global_position.x -= 6
				global_position.y += -24
				

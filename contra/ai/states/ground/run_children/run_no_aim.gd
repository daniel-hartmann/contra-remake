class_name RunNoAim extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.torso_animation.play("run_no_aim")
	character.legs_animation.play("not_running_legs")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if direction == 0.0:
		return
		
	if Input.is_action_just_pressed("shoot"):
		transitioned.emit(self, "runaimmid")

	if Input.is_action_pressed("up"):
		transitioned.emit(self, "runaimhigh")
		
	elif Input.is_action_pressed("down"):
		transitioned.emit(self, "runaimlow")
		
	#if character.firing():
		#character.torso_animation.play("run_aim_mid")
	#else:
		#character.torso_animation.play("run_no_aim")
	

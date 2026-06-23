class_name RunAimLow extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.torso_animation.play("run_aim_low")
	character.legs_animation.play("not_running_legs")
	
func physics_update(delta: float) -> void:
	if Input.is_action_pressed("up"):
		transitioned.emit(self, "runaimhigh")
	
	elif !Input.is_action_pressed("down"):
		transitioned.emit(self, "runnoaim")

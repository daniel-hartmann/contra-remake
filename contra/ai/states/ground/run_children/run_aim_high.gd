class_name RunAimHigh extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.torso_animation.play("run_aim_high")
	character.legs_animation.play("not_running_legs")

func physics_update(delta: float) -> void:
	if Input.is_action_pressed("down"):
		transitioned.emit(self, "runaimdown")
	
	elif !Input.is_action_pressed("up"):
		# TODO: check if it's pressing right or left and firing?
		transitioned.emit(self, "runnoaim")

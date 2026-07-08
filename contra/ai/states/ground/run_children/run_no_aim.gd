class_name RunNoAim extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.torso_animation.play("run_no_aim")
	#character.legs_animation.play("not_running_legs")

	

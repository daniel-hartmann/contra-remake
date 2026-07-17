class_name RunAimLow extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.torso_animation.play("run_aim_low")
	
#func physics_update(delta: float) -> void:
	#if Input.is_action_just_pressed("shoot"):
		#character.torso_animation.stop()
		#character.torso_animation.play("run_aim_low_firing")


func _on_bill_bullet_fired() -> void:
	if character.torso_animation.animation == "run_aim_low":
		character.torso_animation.stop()
		character.torso_animation.play("run_aim_low_firing")

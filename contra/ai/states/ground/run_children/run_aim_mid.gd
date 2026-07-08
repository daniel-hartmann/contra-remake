class_name RunAimMid extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.torso_animation.play("run_aim_mid")
	character.legs_animation.play("running_legs")
	
func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		character.torso_animation.stop()
		character.torso_animation.play("run_aim_mid_firing")

func _on_weapon_cooldown_timeout() -> void:
	if character.fsm.current_state.name == "Ground" and character.fsm.current_state.current_state.name == "Run":
		transitioned.emit(self, "runnoaim")

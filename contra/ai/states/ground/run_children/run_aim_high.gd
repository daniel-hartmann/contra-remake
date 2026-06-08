class_name RunAimHigh extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("run_aim_high")

func physics_update(delta: float) -> void:
	if Input.is_action_pressed("down"):
		transitioned.emit(self, "runaimdown")
	
	elif !Input.is_action_pressed("up"):
		transitioned.emit(self, "runnoaim")

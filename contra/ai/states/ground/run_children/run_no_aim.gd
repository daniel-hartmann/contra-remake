class_name RunNoAim extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("run_no_aim")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if direction == 0.0:
		return

	# FIXME: 
	if Input.is_action_pressed("shoot"):
		character.animated_sprite.play("run_aim_mid")
		

	if Input.is_action_pressed("up"):
		transitioned.emit(self, "runaimhigh")
		
	elif Input.is_action_pressed("down"):
		transitioned.emit(self, "runaimlow")
	

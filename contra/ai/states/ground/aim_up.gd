class_name AimUp extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.is_jumping = false
	character.torso_animation.play("aim_up")
	character.legs_animation.play("not_running_legs")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)

	if not character.is_on_floor():
		transitioned.emit(self, "fall")
		return

	if Input.is_action_pressed("down"):
		transitioned.emit(self, "crouch")
		return

	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "air")
		return

	if direction != 0:
		transitioned.emit(self, "run")
		return
		
	if !Input.is_action_pressed("up"):
		transitioned.emit(self, "idle")


func _on_bill_bullet_fired() -> void:
	if character.torso_animation.animation == "aim_up" or character.torso_animation.animation == "aim_up_firing":
		character.torso_animation.play("aim_up_firing")

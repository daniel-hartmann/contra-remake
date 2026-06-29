class_name Idle extends State

@onready var character := owner as CharacterBody2D
@export var collision_shape: Shape2D

func enter() -> void:
	character.is_jumping = false
	character.torso_animation.play("idle")
	character.legs_animation.play("not_running_legs")
	character.hitbox_shape.shape = collision_shape

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)

	if not character.is_on_floor():
		transitioned.emit(self, "fall")
		return

	if Input.is_action_pressed("down"):
		transitioned.emit(self, "crouch")
		return
		
	if Input.is_action_just_pressed("up"):
		transitioned.emit(self, "aimup")
		return

	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "air")
		return

	if direction != 0:
		transitioned.emit(self, "run")


func _on_bill_bullet_fired() -> void:
	if character.torso_animation.animation == "idle" or character.torso_animation.animation == "idle_firing":
		character.torso_animation.play("idle_firing")

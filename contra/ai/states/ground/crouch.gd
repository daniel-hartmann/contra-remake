class_name Crouch extends State

@onready var character := owner as CharacterBody2D
@export var collision_shape: Shape2D

func enter() -> void:
	character.velocity.x = 0
	character.torso_animation.play("crouch")
	character.legs_animation.play("not_running_legs")
	character.hitbox_shape.shape = collision_shape
	# FIXME: the exit is not guaranteed to be called, so we need to find another way to fix the position
	#character.hitbox_shape.position.y += 8

#func exit() -> void:
	#character.hitbox_shape.position.y -= 8

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if not character.is_on_floor():
		transitioned.emit(self, "fall")
		return

	if direction != 0:
		transitioned.emit(self, "run")
		return

	if not Input.is_action_pressed("down"):
		transitioned.emit(self, "idle")
		return

	if Input.is_action_just_pressed("jump"):
		character.set_collision_mask_value(1, false)
		character.is_jumping = false
		character.get_node("DropTimer").start()
		transitioned.emit(self, "fall")
		return

	character.velocity.x = 0


func _on_bill_bullet_fired() -> void:
	if character.torso_animation.animation == "crouch" or character.torso_animation.animation == "crouch_firing":
		character.torso_animation.play("crouch_firing")

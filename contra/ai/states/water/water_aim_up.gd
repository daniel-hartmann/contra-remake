class_name WaterAimUp extends State

@onready var character := owner as CharacterBody2D
@export var collision_shape: Shape2D

func enter() -> void:
	character.torso_animation.play("water_aim_up")
	character.legs_animation.play("not_running_legs")


func _on_weapon_cooldown_timeout() -> void:
	pass # Replace with function body.

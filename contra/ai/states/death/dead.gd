class_name Dead extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	PlayerStats.player_died()

	character.torso_animation.play("dead")
	character.legs_animation.play("not_running_legs")
	character.torso_animation.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished() -> void:
	# TODO: check if player still have lives
	character.respawn()


func physics_update(delta: float) -> void:
	pass

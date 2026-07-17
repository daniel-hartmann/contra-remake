class_name Dead extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	PlayerStats.player_died()

	character.torso_animation.play("dead")
	character.legs_animation.play("not_running_legs")
	character.torso_animation.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished() -> void:
	if PlayerStats.current_lives > 0:
		character.respawn()
	else:
		character.hide()

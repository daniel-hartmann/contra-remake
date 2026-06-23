class_name Dying extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.torso_animation.play("dying")
	character.legs_animation.play("not_running_legs")
	character.torso_animation.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished() -> void:
	transitioned.emit(self, "enemydead")

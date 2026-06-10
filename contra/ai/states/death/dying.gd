class_name Dying extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("dying")
	character.animated_sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished() -> void:
	transitioned.emit(self, "dead")

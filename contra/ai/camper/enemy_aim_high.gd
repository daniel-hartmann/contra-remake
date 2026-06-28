class_name EnemyAimHigh extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("aim_high")


func physics_update(delta: float) -> void:
	if character.is_firing and character.animated_sprite.animation != "aim_high_firing":
		character.animated_sprite.play("aim_high_firing")
	elif not character.is_firing:
		character.animated_sprite.play("aim_high")

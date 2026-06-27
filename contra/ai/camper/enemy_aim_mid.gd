class_name EnemyAimMid extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("aim_mid")

func physics_update(delta: float) -> void:
	if character.is_dead:
		transitioned.emit(self, "enemydying")

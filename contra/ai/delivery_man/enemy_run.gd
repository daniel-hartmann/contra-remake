class_name EnemyRun extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("run")

func physics_update(delta: float) -> void:
	var direction = -1
	character.velocity.x = direction * character.SPEED
	character.animated_sprite.flip_h = direction < 0
	

class_name EnemyDead extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("dead")
	character.animated_sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)


func _on_animation_finished() -> void:
	character.reset()


func physics_update(delta: float) -> void:
	if not character.is_dead:
		transitioned.emit(self, "enemyrun")

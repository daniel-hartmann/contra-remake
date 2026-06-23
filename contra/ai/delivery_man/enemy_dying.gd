class_name EnemyDying extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("dying")
	var tween = character.create_tween()
	tween.tween_property(character, "global_position", character.global_position+ Vector2(8, -16), 0.2)
	character.animated_sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
	character.toggle_collisions(false)


func _on_animation_finished() -> void:
	transitioned.emit(self, "enemydead")

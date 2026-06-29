class_name EnemyHidden extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	character.animated_sprite.play("emerge")
	character.animated_sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)


func _on_animation_finished() -> void:
	character.animated_sprite.play("hidden")
	character.animated_sprite.animation_finished.connect(_on_hidden_animation_finished, CONNECT_ONE_SHOT)


func _on_hidden_animation_finished() -> void:
	character.animated_sprite.play("emerge")
	character.animated_sprite.animation_finished.connect(_on_emerge_animation_finished, CONNECT_ONE_SHOT)


func _on_emerge_animation_finished() -> void:
	transitioned.emit(self, "enemyaimmid")

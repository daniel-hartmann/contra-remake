extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	enter_child(initial_state.name)


func physics_update(delta: float) -> void:
	super(delta)

	#var facing_right = character.player.global_position.x >= character.global_position.x
	#character.animated_sprite.flip_h = !facing_right

	if character.visible and character.is_dead and not (current_state is EnemyDying or current_state is EnemyDead):
		enter_child("enemydying")

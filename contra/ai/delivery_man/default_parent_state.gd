extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	enter_child(initial_state.name)


func physics_update(delta: float) -> void:
	super(delta)

	if character.visible and character.is_dead and not (current_state is EnemyDying or current_state is EnemyDead):
		enter_child("enemydying")

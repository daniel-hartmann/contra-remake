class_name Dead extends State

@onready var character := owner as CharacterBody2D

func enter() -> void:
	# TODO: remove collision from character and add a timeout to respawn
	PlayerStats.player_died()

func physics_update(delta: float) -> void:
	pass

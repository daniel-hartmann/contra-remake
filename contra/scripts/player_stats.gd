extends Node


var max_lives: int = 5
var current_lives: int = 3
var gun_type: PowerUp.Type
var gun_damage: float = 1.0

signal lives_changed()
signal game_over

func player_died():
	current_lives -= 1
	lives_changed.emit()

	if current_lives <= 0:
		game_over.emit()
		print("Game Over!")
	else:
		respawn_player()

func respawn_player():
	# TODO: move player to new spawn point
	pass

func set_gun(type: PowerUp.Type, damage: float):
	self.gun_type = type
	self.gun_damage = damage

extends Node

# DEFAULTS
const LIVES: int = 3
const GUN_TYPE: PowerUp.Type = PowerUp.Type.DEFAULT_GUN
const GUN_DAMAGE: float = 1.0

var max_lives: int = 5
var current_lives: int = LIVES
var gun_type: PowerUp.Type = GUN_TYPE
var gun_damage: float = GUN_DAMAGE

var current_gun: Variant = Gun.DefaultGun

signal lives_changed()
signal game_over

func player_died():
	current_lives -= 1
	lives_changed.emit()

	if current_lives <= 0:
		game_over.emit()
		print("Game Over!")


func set_gun(gun: Variant):
	self.current_gun = gun


func restart() -> void:
	current_lives = LIVES
	current_gun = Gun.DefaultGun
	

class_name EnemyPool
extends Node

func get_available() -> Enemy:
	for enemy in get_children():
		if enemy.is_dead:
			return enemy
	return null

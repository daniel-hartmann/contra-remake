class_name EnemyPool
extends Node

func get_available() -> Enemy:
	for enemy in get_children():
		if not enemy.visible and not enemy.disabled:
			return enemy
	return null

extends Area2D

@export var water_in_duration: float = 0.2


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(node):
	if node is Player:
		if node.is_dead:
			return
		node.is_on_water = true
		node.torso_animation.play("water_in")
		node.legs_animation.play("not_running_legs")
		await get_tree().create_timer(water_in_duration).timeout
		if is_instance_valid(node):
			_player_on_water_timer_timeout(node)
		return

	if node is Enemy:
		node.animated_sprite.play("water_in")
		await get_tree().create_timer(water_in_duration).timeout
		if is_instance_valid(node):
			_enemy_on_water_timer_timeout(node)


func _player_on_water_timer_timeout(node) -> void:
	node.torso_animation.play("water")
	node.legs_animation.play("not_running_legs")

func _enemy_on_water_timer_timeout(node) -> void:
	node.reset()

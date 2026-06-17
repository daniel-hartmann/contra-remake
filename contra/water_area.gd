extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(node):
	if node is Player:
		if node.is_dead:
			return
		node.is_on_water = true
		node.animated_sprite.play("water_in")
		$WaterTimer.timeout.connect(_player_on_water_timer_timeout.bind(node))
		$WaterTimer.start()
		return
	
	if node is Enemy:
		node.animated_sprite.play("water_in")
		$WaterTimer.timeout.connect(_enemy_on_water_timer_timeout.bind(node))
		$WaterTimer.start()


func _player_on_water_timer_timeout(node) -> void:
	node.animated_sprite.play("water")


func _enemy_on_water_timer_timeout(node) -> void:
	node.die()

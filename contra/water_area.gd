extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(node):
	if node is Player:
		if node.is_dead:
			return
		node.is_on_water = true
		node.torso_animation.play("water_in")
		node.legs_animation.play("not_running_legs")
		$WaterTimer.timeout.connect(_player_on_water_timer_timeout.bind(node))
		$WaterTimer.start()
		return
	
	if node is Enemy:
		node.torso_animation.play("water_in")
		node.legs_animation.play("not_running_legs")
		$WaterTimer.timeout.connect(_enemy_on_water_timer_timeout.bind(node))
		$WaterTimer.start()


func _player_on_water_timer_timeout(node) -> void:
	node.torso_animation.play("water")
	node.legs_animation.play("not_running_legs")

func _enemy_on_water_timer_timeout(node) -> void:
	node.hide()

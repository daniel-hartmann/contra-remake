extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(node):
	if node is Player and not node.is_on_water:
		print("_on_water_area_body_entered")
		node.is_on_water = true
		$WaterTimer.timeout.connect(_on_water_timer_timeout.bind(node))
		#node.animated_sprite.play("water_in")
		#$FSM.on_chi∫˜ld_transition($FSM.current_state, "water")
		$WaterTimer.start()


func _on_water_timer_timeout(node) -> void:
	node.animated_sprite.play("water")

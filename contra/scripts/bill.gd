extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -230.0

var is_jumping := false
var is_on_water := false

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() / 2 * delta

	move_and_slide()


func _on_drop_timer_timeout() -> void:
	set_collision_mask_value(1, true)


func _on_water_area_body_entered(body: Node2D) -> void:
	if body.name == "Bill" and not is_on_water:
		print("_on_water_area_body_entered")
		print(body)
		is_on_water = true
		animated_sprite.play("water_in")
		$WaterTimer.start()
		


func _on_water_area_body_exited(body: Node2D) -> void:
	if body.name == "Bill" and is_on_water:
		print("_on_water_area_body_exited")
		$FSM.on_child_transition($FSM.current_state, "ground")


func _on_water_timer_timeout() -> void:
	print("_on_water_timer_timeout")
	$FSM.on_child_transition($FSM.current_state, "water")


func _on_back_to_the_ground_body_entered(body: Node2D) -> void:
	if body.name == "Bill" and is_on_water:
		print("_on_back_to_the_ground_body_entered")
		$FSM.on_child_transition($FSM.current_state, "ground")

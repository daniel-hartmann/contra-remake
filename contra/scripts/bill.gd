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
	print("_on_water_area_body_entered")
	print(body)
	if body.name == "Bill":
		is_on_water = true
		$FSM.on_child_transition($FSM.current_state, "water")


func _on_water_area_body_exited(body: Node2D) -> void:
	if body.name == "Bill":
		$FSM.on_child_transition($FSM.current_state, "ground")

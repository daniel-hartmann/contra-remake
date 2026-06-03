extends CharacterBody2D
class_name Player

const SPEED = 60.0
const JUMP_VELOCITY = -230.0

var is_jumping := false
var is_on_water := false
var is_climbing := false

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor() and not is_on_water:
		velocity += get_gravity() / 2 * delta

	move_and_slide()
	
	# Detect collisions after moving
	#for i in range(get_slide_collision_count()):
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		#
		## Check if the collided object is a specific StaticBody2D
		#if collider.name == "YourStaticBodyName":
			#print("Collided with the specific StaticBody2D!")


func _on_drop_timer_timeout() -> void:
	set_collision_mask_value(1, true)


func _on_water_area_body_entered(body: Node2D) -> void:
	if body.name == "Bill" and not is_on_water:
		print("_on_water_area_body_entered")
		is_on_water = true
		animated_sprite.play("water_in")
		$WaterTimer.start()


func _on_water_timer_timeout() -> void:
	print("_on_water_timer_timeout")
	$FSM.on_child_transition($FSM.current_state, "water")


func _on_back_to_the_ground_body_entered(body: Node2D) -> void:
	if body.name == "Bill" and is_on_water:
		print("_on_back_to_the_ground_body_entered")
		is_on_water = false
		animated_sprite.play("water_out")
		is_climbing = true
		$BackToGroundTimer.start()
		#$FSM.current_state.enter_child("climb")


func _on_back_to_ground_timer_timeout() -> void:
	print("_on_back_to_ground_timer_timeout")
	is_on_water = false
	is_climbing = false
	global_position.y -= 16
	$FSM.on_child_transition($FSM.current_state, "ground")

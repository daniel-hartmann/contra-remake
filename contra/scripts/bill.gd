extends CharacterBody2D
class_name Player

const SPEED = 60.0
const JUMP_VELOCITY = -230.0

var is_jumping := false
var is_on_water := false
var is_climbing := false

@onready var animated_sprite = $AnimatedSprite2D

const BULLET = preload("res://Bullet.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor() and not is_on_water:
		velocity += get_gravity() / 2 * delta

	move_and_slide()
	#
	## Detect collisions after moving
	#for i in range(get_slide_collision_count()):
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
#
		#if collider is TileMapLayer:
			#var tile_set = collider.tile_set
			#if tile_set:
				## 0 refers to the first Physics Layer setup in your TileSet inspector
				#var layer = tile_set.get_physics_layer_collision_layer(0)
				#var mask = tile_set.get_physics_layer_collision_mask(0)
				#print("Hit a TileMapLayer tile. Layer: ", layer, " Mask: ", mask)
#
#
#
		## Check if the collided object is a specific StaticBody2D
		#if collider.name == "YourStaticBodyName":
			#print("Collided with the specific StaticBody2D!")


func _on_drop_timer_timeout() -> void:
	set_collision_mask_value(1, true)



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
	
func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot()

func shoot():
	# 1. Create an instance of the bullet
	var b = BULLET.instantiate()
	# 2. Set the bullet's position and rotation
	b.global_position = $Mira.global_position
	
	if $"FSM".current_state.name == "Ground":
		if $"FSM".current_state.current_state.name == "Run":
			if $"FSM".current_state.current_state.current_state.name == "RunAimHigh":
				b.global_rotation_degrees = -40
			elif $"FSM".current_state.current_state.current_state.name == "RunAimLow":
				b.global_rotation_degrees = 40
		elif $"FSM".current_state.current_state.name == "AimUp":
			b.global_rotation_degrees = -90
			
	if $AnimatedSprite2D.flip_h:
		b.global_rotation_degrees = 180 - b.global_rotation_degrees

	# 3. Add it to the main scene (instead of the player, so it doesn't move with the player)
	get_parent().add_child(b)

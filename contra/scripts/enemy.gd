class_name Enemy extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -230.0

@onready var animated_sprite = $AnimatedSprite2D
var is_dead: bool = true

# For testing with less enemies
@export var disabled: bool = false

func _ready() -> void:
	reset()


func toggle_collisions(collide: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", !collide)
	$Hitbox/CollisionShape2D.set_deferred("disabled", !collide)


func reset() -> void:
	$FSM.set_physics_process(false)
	set_physics_process(false)
	toggle_collisions(false)
	is_dead = true
	global_position = Vector2(-100, -100)


func spawn():
	$FSM.set_physics_process(true)
	$FSM.current_state.enter_child($FSM.initial_state.name)
	set_physics_process(true)
	toggle_collisions(true)
	is_dead = false
	show()


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() / 2 * delta

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Bullet:
		is_dead = true
		# TODO: use the bullet.die or something that will be created
		area.queue_free()

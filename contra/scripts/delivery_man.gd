class_name Enemy extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -230.0

@onready var animated_sprite = $AnimatedSprite2D
var is_dead: bool = false


func reset() -> void:
	is_dead = true
	hide()
	global_position = Vector2(-100, -100)


func spawn():
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
		area.hide()

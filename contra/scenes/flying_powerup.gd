class_name FlyingPowerUp extends CharacterBody2D

var time: float = 0.0
@export var speed: float = 70.0
@export var frequency: float = 5.0
@export var amplitude: float = 100.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var stop = false
var power_up_instantiated = false

const POWER_UP = preload("res://scenes/power_up.tscn")

func _ready() -> void:
	hide()
	set_physics_process(false)
	animated_sprite.play("flying")
	animated_sprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func _physics_process(delta: float) -> void:
	# Accumulate time
	time += delta
	
	# Calculate the sine wave for the vertical velocity
	var vertical_velocity: float = sin(time * frequency) * amplitude
	
	# Set velocity: X moves forward, Y moves in the sine wave
	velocity = Vector2(speed, vertical_velocity)
	
	if stop:
		velocity = Vector2.ZERO
	
	# Move the character
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if power_up_instantiated:
		return
		
	if area is Bullet:
		stop = true
		area.queue_free()
		animated_sprite.play("exploding")
				
		var power_up = POWER_UP.instantiate()
		power_up.global_position = global_position
		get_tree().current_scene.add_child(power_up)
		power_up_instantiated = true
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "exploding":
		queue_free()
		
func spawn():
	set_physics_process(true)
	show()

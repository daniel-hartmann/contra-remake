class_name Bullet extends Area2D

@export var speed = 180
@onready var sprite = $Sprite2D

const DEFAULT_TEXTURE := preload("res://art/bullets/standard.png")
const MACHINE_GUN_TEXTURE := preload("res://art/bullets/machinegun.png")

var current_texture := DEFAULT_TEXTURE

func setup(texture) -> void:
	current_texture = texture


func _ready() -> void:
	sprite.texture = current_texture


func _physics_process(delta):
	# Move the bullet forward based on its current rotation
	position += transform.x * speed * delta

	if not Utils.get_camera_bounds().has_point(global_position):
		queue_free()


func _on_body_entered(body):
	# Handle hitting an enemy or object here
	queue_free() # Delete the bullet upon impact

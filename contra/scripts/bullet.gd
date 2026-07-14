class_name Bullet extends Area2D

@export var speed = 180
@onready var sprite = $Sprite2D

const DEFAULT_TEXTURE := preload("res://art/bullets/standard.png")
const MACHINE_GUN_TEXTURE := preload("res://art/bullets/machinegun.png")

var current_texture := DEFAULT_TEXTURE


func setup(power_up_type: PowerUp.Type = PowerUp.Type.DEFAULT_GUN) -> void:
	if power_up_type == PowerUp.Type.MACHINE_GUN:
		current_texture = MACHINE_GUN_TEXTURE
	else:
		current_texture = DEFAULT_TEXTURE


func _ready() -> void:
	get_tree().create_timer(3.0).timeout.connect(queue_free)
	sprite.texture = current_texture


func _physics_process(delta):
	# Move the bullet forward based on its current rotation
	position += transform.x * speed * delta


func _on_body_entered(body):
	# Handle hitting an enemy or object here
	queue_free() # Delete the bullet upon impact

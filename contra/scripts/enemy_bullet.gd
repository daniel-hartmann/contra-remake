class_name EnemyBullet extends Area2D

@export var speed = 180
@onready var sprite = $Sprite2D

func _ready() -> void:
	get_tree().create_timer(3.0).timeout.connect(queue_free)


func _physics_process(delta):
	# Move the bullet forward based on its current rotation
	position += transform.x * speed * delta


func _on_body_entered(body):
	# Handle hitting an enemy or object here
	queue_free() # Delete the bullet upon impact

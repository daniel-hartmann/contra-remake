class_name Bullet extends Area2D

@export var speed = 180

func _physics_process(delta):
	# Move the bullet forward based on its current rotation
	position += transform.x * speed * delta

func _on_body_entered(body):
	# Handle hitting an enemy or object here
	queue_free() # Delete the bullet upon impact

extends RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var was_colliding := false

func _process(delta):
	var colliding_now = is_colliding()
	if colliding_now and not was_colliding:
		print("colliding!")
	was_colliding = colliding_now

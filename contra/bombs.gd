extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	$bomb01.show()
	await get_tree().create_timer(1.5).timeout
	$bomb03.show()
	await get_tree().create_timer(2.0).timeout
	$bomb02.show()
	await get_tree().create_timer(3.).timeout
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

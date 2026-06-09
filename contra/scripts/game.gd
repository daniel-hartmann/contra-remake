extends Node

func _ready() -> void:
	change_screen(preload("res://scenes/stages/stage_one.tscn").instantiate())


func change_screen(scene):
	for child in get_children():
		child.queue_free()

	add_child(scene)

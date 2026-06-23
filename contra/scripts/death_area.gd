extends Area2D
class_name DeathArea


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		print("RESET ENEMY")
		body.reset()

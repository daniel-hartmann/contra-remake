class_name TurretExplode extends State

@onready var turret := owner as Area2D

func enter() -> void:
	turret.toggle_collisions(false)
	turret.animated_sprite.play("explode")
	turret.animated_sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished() -> void:
	turret.queue_free()

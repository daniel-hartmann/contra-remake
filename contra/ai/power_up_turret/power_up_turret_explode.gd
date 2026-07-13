class_name PowerUpTurretExplode extends State

@onready var turret := owner as Area2D

func enter() -> void:
	turret.animated_sprite.play("explode")
	turret.animated_sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

	var power_up = turret.POWER_UP_SCENE.instantiate()
	power_up.global_position = turret.global_position
	var tween = power_up.create_tween()
	tween.tween_property(power_up, "global_position", turret.global_position+ Vector2(38, -66), 0.8)
	turret.get_parent().add_child(power_up)


func _on_animation_finished() -> void:
	turret.queue_free()

class_name TurretOpened extends State

@onready var turret := owner as Area2D

func enter() -> void:
	turret.is_aiming = false
	turret.animated_sprite.play("opening")
	turret.animated_sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished() -> void:
	turret.is_aiming = true

func physics_update(delta: float) -> void:
	if turret.life <= 0.0:
		turret.is_aiming = false
		transitioned.emit(self, "turretexplode")

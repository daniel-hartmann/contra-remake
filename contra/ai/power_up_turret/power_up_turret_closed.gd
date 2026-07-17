class_name PowerUpTurretClosed extends State

@onready var turret := owner as Area2D

func enter() -> void:
	turret.animated_sprite.play("closed")

func physics_update(delta: float) -> void:
	if turret.on_screen:
		transitioned.emit(self, "powerupturretopened")

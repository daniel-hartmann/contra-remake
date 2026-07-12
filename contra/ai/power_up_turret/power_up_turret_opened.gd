class_name PowerUpTurretOpened extends State

@onready var turret := owner as Area2D

func enter() -> void:
	turret.animated_sprite.play("animated")


func physics_update(delta: float) -> void:
	if turret.life <= 0.0:
		transitioned.emit(self, "powerupturretexplode")

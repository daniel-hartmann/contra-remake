class_name Gun extends Resource


class DefaultGun extends Gun:
	const DAMAGE := 1.0
	const BULLET_TEXTURE := preload("res://art/bullets/standard.png")
	const MAX_BULLETS := 4
	const FX: AudioStream = preload("res://audio/fx/shotgun_1.wav")

class MachineGun extends Gun:
	const DAMAGE := 2.0
	const BULLET_TEXTURE := preload("res://art/bullets/machinegun.png")
	const MAX_BULLETS := 6
	const FX: AudioStream = preload("res://audio/fx/shotgun_2.wav")

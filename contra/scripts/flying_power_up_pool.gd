class_name FlyingPowerUpPool
extends Node

func get_available() -> FlyingPowerUp:
	for flying_power_up in get_children():
		return flying_power_up
	return null

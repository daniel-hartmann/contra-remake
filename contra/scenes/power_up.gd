extends RigidBody2D
class_name PowerUp



enum Type {
	BARRIER,
	DEFAULT_GUN,
	FIREBALL_GUN,
	MACHINE_GUN,
	RAPID_FIRE,
	SPREAD_GUN,
}



@export var fx: AudioStream
@export var type: Type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_contact_count() > 0:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0


func activate() -> void:
	# Check the type and enable the power up in PlayeStats
	AudioManager.play_sound_effect(fx)

	var gun = Gun.DefaultGun

	match type:
		Type.MACHINE_GUN:
			gun = Gun.MachineGun
		#Type.FIREBALL_GUN:
			#gun = Gun.FireballGun
		#Type.SPREAD_GUN:
			#gun = Gun.SpreadGun

	PlayerStats.set_gun(gun)

	queue_free()

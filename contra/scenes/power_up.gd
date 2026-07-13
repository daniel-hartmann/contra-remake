extends RigidBody2D
class_name PowerUp


enum Type {
	BARRIER,
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
	pass


func activate() -> void:
	# Check the type and enable the power up in PlayeStats
	AudioManager.play_sound_effect(fx)

	if type in [Type.FIREBALL_GUN, Type.MACHINE_GUN, Type.SPREAD_GUN]:
		# TODO: check damage of each gun
		PlayerStats.set_gun(type, 2)

	queue_free()

extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var on_screen := false
var life: float = 3.0

const POWER_UP_SCENE = preload("res://scenes/power_up.tscn")

@export var power_up_type: PowerUp.Type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	on_screen = true


func _on_area_entered(area: Area2D) -> void:
	print(area)
	if area is Bullet:
		life -= PlayerStats.gun_damage

		# TODO: use the bullet.die or something that will be created
		area.queue_free()

extends Node2D

@onready var trigger_area = $trigger_area
@onready var bridge_walk_on = $Bridge_walk_on/walk_on

@export var bombs: PackedScene
#@onready var bill = $"../Bill"  

# bomb01
#@onready var b01 = $bomb01
#@onready var b01_smoke  = $bomb01/smoke
#@onready var b01_smoke2 = $bomb01/smoke2

# bomb02
#@onready var b02 = $bomb02
#@onready var b02_smoke  = $bomb02/smoke
#@onready var b02_smoke2 = $bomb02/smoke2

# bomb03
#@onready var b03 = $bomb03
#@onready var b03_smoke  = $bomb03/smoke
#@onready var b03_smoke2 = $bomb03/smoke2

var triggered = false

func _ready() -> void:
	trigger_area.body_entered.connect(_on_trigger_body_entered)

func _on_trigger_body_entered(body: Node2D) -> void:
	print(body.name)
	if body is Player:
		var b=bombs.instantiate()
		b.global_position= self.global_position
		self.get_parent().add_child(b)
		await get_tree().create_timer(2.0).timeout
		queue_free()
	

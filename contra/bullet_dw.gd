extends Area2D

@export var speed = 30
@export var fall_gravity = 30

@onready var sprite: AnimatedSprite2D = $hit

var velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	get_tree().create_timer(3.0).timeout.connect(queue_free)
	body_entered.connect(_on_body_entered)
	sprite.play()


func launch() -> void:
	velocity = transform.x * speed


func _physics_process(delta: float) -> void:
	velocity.y += fall_gravity * delta
	position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	explode()


func explode() -> void:
	print("Bomba explodiu em: ", global_position)
	sprite.stop()
	queue_free()

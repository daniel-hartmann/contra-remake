class_name Dying extends State

@onready var character := owner as CharacterBody2D

var start_position: Vector2
var arc_height := 16.0
var arc_distance := -25.0

func enter() -> void:
	character.torso_animation.play("dying")
	character.legs_animation.play("not_running_legs")
	character.torso_animation.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

	start_position = character.global_position
	var tween = character.create_tween()
	tween.tween_method(_update_arc_position, 0.0, 1.0, 0.6).set_trans(Tween.TRANS_LINEAR)


func _update_arc_position(t: float) -> void:
	var x = start_position.x + arc_distance * t
	var y_offset = -arc_height * (4.0 * t * (1.0 - t))
	character.global_position = Vector2(x, start_position.y + y_offset)


func _on_animation_finished() -> void:
	transitioned.emit(self, "dead")

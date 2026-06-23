class_name Run extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	enter_child("runnoaim")
	
func exit() -> void:
	enter_child("runnoaim")

func _shared_physics(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if not character.is_on_floor() or Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "air")
		return

	if Input.is_action_pressed("down") and direction == 0:
		transitioned.emit(self, "crouch")
		return

	if direction == 0:
		transitioned.emit(self, "idle")
		return

	character.velocity.x = direction * character.SPEED
	character.torso_animation.flip_h = direction < 0
	character.legs_animation.flip_h = direction < 0

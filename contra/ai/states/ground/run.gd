class_name Run extends ParentState

@onready var character := owner as CharacterBody2D

func enter() -> void:
	if !character.firing():
		enter_child("runnoaim")
	else:
		enter_child("runaimmid")
	character.legs_animation.play("running_legs")
	
func exit() -> void:
	character.legs_animation.play("not_running_legs")

func _shared_physics(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if not character.is_on_floor() or Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "air")
		return

	if Input.is_action_pressed("down") and direction == 0:
		transitioned.emit(self, "crouch")
		return

	if direction == 0:
		if Input.is_action_pressed("up"):
			transitioned.emit(self, "aimup")
		else:
			transitioned.emit(self, "idle")
		return
	
	character.velocity.x = direction * character.SPEED
	character.torso_animation.flip_h = direction < 0
	character.legs_animation.flip_h = direction < 0
		
	if Input.is_action_just_pressed("shoot") and not Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		enter_child("runaimmid")
	elif Input.is_action_pressed("up"):
		enter_child("runaimhigh")
	elif Input.is_action_pressed("down"):
		enter_child("runaimlow")
	elif !character.firing():
		enter_child("runnoaim")

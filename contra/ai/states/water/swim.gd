class_name Swim extends ParentState

@onready var character := owner as CharacterBody2D
@export var collision_shape: Shape2D

func enter() -> void:
	enter_child("basicswim")

func _shared_physics(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	
	do_shooting()

	if Input.is_action_pressed("down") and direction == 0:
		transitioned.emit(self, "dive")
		return

	if direction == 0:
		character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)
		return

	character.velocity.x = direction * character.SPEED
	
	if character.is_climbing:
		character.velocity.x = 0
			
	character.torso_animation.flip_h = direction < 0
	
func do_shooting() -> void:
	var direction := Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("shoot") and not Input.is_action_pressed("up"):
		enter_child("wateraimmid")
		return
		
	if Input.is_action_just_pressed("shoot") and Input.is_action_pressed("up") and direction == 0:
		enter_child("wateraimup")
		return
		
	if direction != 0 and Input.is_action_just_pressed("shoot") and Input.is_action_pressed("up"):
		enter_child("wateraimhigh")
		return

func _on_weapon_cooldown_timeout() -> void:
	if character.fsm.current_state.name == "Water" and character.fsm.current_state.current_state.name == "Swim":
		enter_child("basicswim")

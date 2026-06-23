class_name Swim extends State

@onready var character := owner as CharacterBody2D
@export var collision_shape: Shape2D

func enter() -> void:
	character.torso_animation.play("water")
	character.legs_animation.play("not_running_legs")
	# TODO: set different collision shapes for each state
	#character.hitbox_shape.shape = collision_shape


func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if Input.is_action_pressed("down") and direction == 0:
		transitioned.emit(self, "dive")
		return

	if direction == 0:
		character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)
		return

	character.velocity.x = direction * character.SPEED
	
	if character.is_climbing:
		character.velocity.x = 0
		
	if Input.is_action_pressed("up") and Input.is_action_just_pressed("shoot"):
		character.velocity.x = 0
		transitioned.emit(self, "wateraimup")
		return
	
	if Input.is_action_just_pressed("up") and direction != 0 and Input.is_action_just_pressed("shoot"):
		transitioned.emit(self, "wateraimhigh")
		
	if Input.is_action_just_pressed("shoot"):
		transitioned.emit(self, "wateraimmid")
	
	character.torso_animation.flip_h = direction < 0
	

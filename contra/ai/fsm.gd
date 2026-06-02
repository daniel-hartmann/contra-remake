class_name FSM extends Node

@export var initial_state: ParentState

var states: Dictionary = {}
var current_state: ParentState

func _ready() -> void:
	for child in get_children():
		if child is ParentState:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)

	await owner.ready

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func on_child_transition(state: ParentState, new_state_name: String):
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())
	
	if not new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state

class_name ParentState extends State

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transition)

func enter_child(state_name: String) -> void:
	var s = states.get(state_name)
	if s:
		s.enter()
		current_state = s
		Log.info("on state " + self.name + " -> " + s.name)

func _on_child_transition(state: State, new_name: String) -> void:
	if state != current_state:
		return

	if current_state is Dying or current_state is Dead:
		return

	if states.has(new_name):
		current_state.exit()
		enter_child(new_name)
	else:
		transitioned.emit(self, new_name)

func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func physics_update(delta: float) -> void:
	_shared_physics(delta)
	if current_state:
		current_state.physics_update(delta)

func _shared_physics(delta: float) -> void:
	pass

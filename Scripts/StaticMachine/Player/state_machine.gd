#state_machine.gd
extends State

@export var starter_state: State
var current_state : State

func init(parent:Player , move_component):
	for child in get_children():
		child.parent = parent
		child.movecomponent = move_component
		
	change_state(starter_state)
	
	
func change_state(new_state: State):
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()

func process_frame(delta: float) :
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)


func process_physics(delta: float):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func process_input(event: InputEvent):
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

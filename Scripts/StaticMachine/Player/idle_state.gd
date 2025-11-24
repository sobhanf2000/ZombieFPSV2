#idle_state.gd
extends State

@export var move_state :State
@export var jump_state :State

func enter():
	parent.velocity = Vector3(0,-Gravity, 0)



func process_input(event: InputEvent):
	var movement = movecomponent.get_movement_direction(parent)
	if movecomponent.wants_jump():
		return jump_state
	if movement != Vector3.ZERO:
		return move_state
	return null



func process_physics(delta: float):
	parent.velocity.y += -Gravity * delta
	parent.move_and_slide() 
	return null

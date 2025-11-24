extends State

@export var idle_state :State
@export var jump_state :State
var movement
func enter():
	pass


func process_input(event: InputEvent):
	movement = movecomponent.get_movement_direction(parent)
	if movement == Vector3.ZERO:
		return idle_state
	if movecomponent.wants_jump() and parent.is_on_floor():
		return jump_state
	return null
	

func process_physics(delta: float):
	parent.velocity.y += -Gravity * delta
	movement = movecomponent.get_movement_direction(parent)
	parent.velocity.x = movement.x * move_speed
	parent.velocity.z = movement.z * move_speed
	parent.move_and_slide() 
	return null
	
	

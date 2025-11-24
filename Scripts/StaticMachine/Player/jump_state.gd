extends State
  
@export var idle_state: State
@export var move_state: State
@export var jump_strengh :float


func enter():
	parent.velocity.y = jump_strengh



func process_physics(delta: float):
	parent.velocity.y += -Gravity * delta
	var movement = movecomponent.get_movement_direction(parent)
	parent.velocity.x = movement.x * move_speed
	parent.velocity.z = movement.z * move_speed
	
	parent.move_and_slide()
	if parent.is_on_floor():
		if parent.velocity == Vector3.ZERO:
			return idle_state
		else: 
			return move_state
	return null

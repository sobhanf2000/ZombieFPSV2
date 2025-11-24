#move_component
extends Node


func get_movement_direction(parent:Player)-> Vector3:
	var dir:Vector3
	var dir2d = Input.get_vector("backward","forward","left","right")
	dir = Vector3(dir2d.x , 0 , dir2d.y)
	#if Input.is_action_pressed("backward"):
	#	dir.z = 1
	#if Input.is_action_pressed("forward"):
	#	dir.z = -1
	#if Input.is_action_pressed("left"):
	#	dir.x = -1
	#if Input.is_action_pressed("right"):
	#	dir.x = 1
	if dir == Vector3.ZERO:
		return Vector3.ZERO
		
	var head_basis = parent.head.global_transform.basis
	var forward = -head_basis.z
	var right = head_basis.x
	
	var move_dir = (forward * dir.x + right * dir.z).normalized()
	return move_dir
	
	
func wants_jump() -> bool:
	return Input.is_action_just_pressed("jump")

class_name State
extends Node

var parent:Player
@export var move_speed:float
var Gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * 3
var movecomponent

func enter():
	pass

func exit():
	pass
	


func process_frame(delta: float):
	return null


func process_physics(delta: float):
	return null


func process_input(event: InputEvent):
	return null

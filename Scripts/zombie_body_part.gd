extends Area3D

@export var damage := 1

signal body_part_hit(dam)


func hit():
	print("hit reported")
	emit_signal("body_part_hit",damage)
	

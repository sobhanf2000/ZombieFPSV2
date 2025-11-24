class_name Player
extends CharacterBody3D


@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera
@onready var state_machine: State = $State_Machine
@onready var move_component: Node = $Move_Component
@onready var rifle_anim: AnimationPlayer = $Head/Camera/Assault_Rifle/AnimationPlayer
@onready var rifle_barrel: Node3D = $Head/Camera/Assault_Rifle/RayCast3D
@onready var shoot_sound: AudioStreamPlayer = $ShootSound

var health = 10

var bullet_origin = load("res://Scenes/bullet.tscn")
var bullet_instance

var hit_stagger = 2

signal player_hit

const SENSIVITY = 0.001


func _ready() -> void:
	state_machine.init(self , move_component)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if !rifle_anim.is_playing():
			rifle_anim.play("shoot")
			shoot_sound.play()
			bullet_instance = bullet_origin.instantiate()
			bullet_instance.position = rifle_barrel.global_position
			bullet_instance.transform.basis = rifle_barrel.global_transform.basis
			get_parent().add_child(bullet_instance)
	
	state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSIVITY)
		camera.rotate_x(-event.relative.y * SENSIVITY)
	state_machine.process_input(event)


func hit(dir , dam):
	emit_signal("player_hit")
	damage(dam)
	velocity += dir * hit_stagger
	velocity = lerp(velocity, Vector3.ZERO,10) 


func damage(dam):
	health -= dam 
	if health <= 0:
		get_tree().reload_current_scene()

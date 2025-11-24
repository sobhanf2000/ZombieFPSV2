extends CharacterBody3D

var player = null
var state_machine
var health = 6


const ATTACK_RANGE = 5

@export var speed : float
@export var origin_zombie: CharacterBody3D

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	state_machine = animation_tree.get("parameters/playback")



func _process(delta: float) -> void:
	velocity = Vector3.ZERO

	# update conditions for state machine
	animation_tree.set("parameters/conditions/attack", target_in_range())
	animation_tree.set("parameters/conditions/run", !target_in_range())


	match state_machine.get_current_node():
		"Run":
			navigation_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = navigation_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * speed
			
			look_at(Vector3(global_position.x + velocity.x , global_position.y ,global_position.z + velocity.z) , Vector3.UP)

		"Attack":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

	move_and_slide()

func target_in_range():
	return global_position.distance_to(player.global_position) <= ATTACK_RANGE


func hit_finished():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE + 1:
		#var dir = Vector3(global_position.distance_to(player.global_position),0,global_position.distance_to(player.global_position)) 
		#var dir = (player.global_position - global_position).normalized()
		var dir = transform.basis.z.normalized()
		player.hit(dir)
	


func _on_area_3d_body_part_hit(dam: Variant) -> void:
	health -=dam
	if health <= 0:
		queue_free()

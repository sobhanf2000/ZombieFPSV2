extends Node3D


@onready var player_hit: ColorRect = $UI/PlayerHit
@onready var navigation_region_3d: NavigationRegion3D = $Map/NavigationRegion3D
@onready var spawn_manager: Node3D = $Map/NavigationRegion3D/Spawn_Manager
@onready var zombie_respawm_timer: Timer = $Zombie_Respawm_Timer

@export var origin_zombie := load("res://Scenes/zombie.tscn")
var zombie_instance

func _ready() -> void:
	
	player_hit.visible = false
	get_random_respawn()
	
	
func _on_player_player_hit() -> void:
	player_hit.visible = true
	await get_tree().create_timer(0.2).timeout
	player_hit.visible = false
	
func get_random_respawn():
	var random_id = randi() % spawn_manager.get_child_count()
	
	var spawn_position = spawn_manager.get_child(random_id).global_position
	zombie_instance = origin_zombie.instantiate()
	zombie_instance.global_position = spawn_position
	var zombie_scale = randf_range(1 , 3)
	zombie_instance.scale = Vector3.ONE * zombie_scale
	navigation_region_3d.add_child(zombie_instance)

func _on_zombie_respawm_timer_timeout() -> void:
	get_random_respawn()

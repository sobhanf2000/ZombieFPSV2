extends Node3D

const SPEED = 60
@onready var ray_cast: RayCast3D = $RayCast3D
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var particles: GPUParticles3D = $GPUParticles3D


func _process(delta: float) -> void:
	position += transform.basis.z * -SPEED  * delta
	if ray_cast.is_colliding():
		mesh_instance.visible = false
		particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free()


func _on_bullet_lifetime_timer_timeout() -> void:
	queue_free()

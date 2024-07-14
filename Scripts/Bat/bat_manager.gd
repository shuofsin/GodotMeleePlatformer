extends Node

@onready var bat: CharacterBody2D = $".."

var is_dead = false 

# Set death for death
func _on_hurtbox_area_entered(area: Area2D) -> void:
	is_dead = true
	bat.sprite.material.set_shader_parameter("active", true)
	if area.collision_layer == 64:
		area.delete = true

func _on_hurtbox_area_exited(area: Area2D) -> void:
	bat.sprite.material.set_shader_parameter("active", false)

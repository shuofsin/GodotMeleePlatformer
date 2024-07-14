extends Node

@onready var hound: CharacterBody2D = $".."
@export var hit_points: int = 1

var is_dead = false 

func _process(delta: float) -> void:
	if hit_points <= 0:
		is_dead = true

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.collision_layer == 64:
		area.delete = true
	hound.sprite.material.set_shader_parameter("active", true)
	hit_points -= 1

func _on_hurtbox_area_exited(area: Area2D) -> void:
	hound.sprite.material.set_shader_parameter("active", false)

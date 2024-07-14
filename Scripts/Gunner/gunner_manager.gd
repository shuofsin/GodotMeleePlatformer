extends Node

@onready var gunner: CharacterBody2D = $".."

# Store the gunner's information
@export var direction = 1
@onready var spawn_position = gunner.position
var see_player = false
var within_range = false
var is_dead = false

# Be the pig
@onready var grunt: AudioStreamPlayer2D = $"../audio/grunt"

func _on_detectbox_area_entered(area: Area2D) -> void:
	see_player = true
	gunner.player = area.get_parent() 
	grunt.playing = true
	

func _on_detectbox_area_exited(area: Area2D) -> void:
	see_player = false

func _on_attackbox_area_entered(area: Area2D) -> void:
	within_range = true

func _on_attackbox_area_exited(area: Area2D) -> void:
	within_range = false

func _on_hurtbox_area_entered(area: Area2D) -> void:
	gunner.sprite.material.set_shader_parameter("active", true)
	is_dead = true
	if area.collision_layer == 64:
		area.delete = true

func _on_hurtbox_area_exited(area: Area2D) -> void:
	gunner.sprite.material.set_shader_parameter("active", false)

class_name State
extends Node

# Export fill-in values for state
@export var animation_name: String

@export var move_speed: float = 100

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Hold reference to parent so that it can be controlled 
var parent: CharacterBody2D

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null 

func process_physics(delta: float) -> State: 
	return null

extends Area2D

@export var sprite: Sprite2D 
@export var damage: int = 1

# Flip with character
func _process(delta: float) -> void: 
	if sprite.flip_h: 
		scale.x = -1
	else:
		scale.x = 1

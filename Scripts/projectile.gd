extends Area2D

# Get speed and animations
@export var speed: int = 100
@onready var animations: AnimationPlayer = $animations

# For explosion purposes
var delete = false

# Move the pulled and explode on impact
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	
	if delete:
		speed = 0
		animations.play("explode")

# Impact
func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explode":
		self.queue_free()

extends CharacterBody2D

# Get bounce parameters
@export var gravity: int = 640
@export var bounce: int = 3

# Throw it into the air 
func _ready() -> void:
	velocity.y = -100

# Hit the ground and bounce
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if is_on_floor():
		velocity.y = bounce * -50
		bounce -= 1
	
	move_and_slide()

# Get picked up by the player
# Done here for the sake of simplicity 
func _on_detectbox_area_entered(area: Area2D) -> void:
	if area.get_parent().manager.has_health_potion == false:
		area.get_parent().manager.has_health_potion = true
		self.queue_free()

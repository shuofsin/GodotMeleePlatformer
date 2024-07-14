extends State

# Can go anywhere from move
@export var idle_state: State
@export var bite_state: State
@export var death_state: State

# Find the position of the player
var player_position: Vector2

# Check conditions
var within_range: bool = false 
var out_of_range: bool = false

# Set starting conditions
func enter() -> void:
	super()
	within_range = false
	out_of_range = false

# Find the player and chase aggressively 
func process_physics(delta: float) -> State: 
	if parent.manager.is_dead:
		return death_state
	
	player_position = parent.player.position
	var target_position = (player_position - parent.position).normalized()
	parent.position += target_position / move_speed
	
	if within_range:
		return bite_state
	if out_of_range:
		return idle_state
	return null

# Check for condition changes
func _on_attackbox_area_entered(area: Area2D) -> void:
	within_range = true

func _on_detectbox_area_exited(area: Area2D) -> void:
	out_of_range = true

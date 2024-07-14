extends State

# Get states
@export var move_state: State
@export var death_state: State

# Set idle movement parameters
@export var direction: int = 1
@export var range: int = 25
var start_position: Vector2
var found_player: bool = false

# Set starting idle parameters
func enter() -> void:
	super()
	direction = 1
	start_position = parent.position
	found_player = false

# Move back and forth, change if conditions change
func process_physics(delta: float) -> State: 
	if parent.manager.is_dead:
		return death_state
	
	parent.velocity.x = direction * move_speed
	
	if parent.position.x - start_position.x > range and direction == 1:
		direction = -1
	if parent.position.x - start_position.x < -range and direction == -1:
		direction = 1
	
	parent.move_and_slide()
	
	if found_player:
		return move_state
	
	return null

# Check if player is nearby
func _on_detectbox_area_entered(area: Area2D) -> void:
	parent.player = area.get_parent()
	found_player = true

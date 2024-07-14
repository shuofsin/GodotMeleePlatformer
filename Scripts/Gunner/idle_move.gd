extends State

# Can go anywhere from here
@export var idle_still_state: State
@export var attack_move_state: State
@export var attack_shoot_state: State
@export var death_fall_state: State

var hit_marker = false
# Set starting direction
func enter() -> void:
	super()
	hit_marker = false

# Move a horizontal direction and go down
func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_fall_state
	parent.velocity.y += gravity * delta
	var movement = parent.manager.direction * move_speed
	
	parent.sprite.flip_h = movement < 0
	parent.velocity.x = movement
	
	parent.move_and_slide()
	
	if hit_marker:
		return idle_still_state
	if parent.manager.see_player:
		return attack_move_state
	return null

# Flip if barrier found
func _on_markerbox_area_entered(area: Area2D) -> void:
	hit_marker = true

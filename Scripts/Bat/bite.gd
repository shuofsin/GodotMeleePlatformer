extends State

# Can go anywhere from bite 
@export var idle_state: State
@export var move_state: State
@export var bite_state: State
@export var death_state: State

# For deciding next state
var attack_finished: bool = false
var within_attack_range: bool = true
var within_chase_range: bool = true

# Set condition checker default
func enter() -> void:
	super()
	attack_finished = false
	within_attack_range = true
	within_chase_range = true

# Decided to move on after animation
func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_state
	
	if attack_finished:
		if within_attack_range:
			return bite_state
		if within_chase_range:
			return move_state
		return idle_state
	
	return null

# Check for condition change 
func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		attack_finished = true

func _on_detectbox_area_exited(area: Area2D) -> void:
	within_chase_range = false

func _on_attackbox_area_exited(area: Area2D) -> void:
	within_attack_range = false

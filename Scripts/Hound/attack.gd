extends State

# Can go anywhere from here
@export var idle_state: State
@export var move_state: State
@export var attack_state: State
@export var death_state: State

# Check conditions
var attack_finished = false
var within_attack_range = true
var found_player = true

# Set starting condition and remember player "scent" 
func enter() -> void:
	super()
	parent.velocity.x = 0 
	attack_finished = false
	within_attack_range = true
	found_player = true
	var direction = sign((parent.player.global_position - parent.global_position).x)
	parent.sprite.flip_h = direction < 0

# Decide next course based on conditions
func process_physics(delta: float) -> State: 
	if parent.manager.is_dead:
		return death_state

	if attack_finished: 
		if within_attack_range:
			return attack_state
		elif found_player: 
			return move_state
		else:
			return idle_state
	return null

# Check for conditions
func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		attack_finished = true

func _on_detectbox_area_exited(area: Area2D) -> void:
	found_player = false

func _on_attack_box_area_exited(area: Area2D) -> void:
	within_attack_range = false

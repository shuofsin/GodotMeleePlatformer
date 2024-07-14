extends State

@export var idle_state: State
@export var move_state: State
@export var death_fall_state: State

var drink_finished = false
var selection: bool

func enter() -> void:
	selection = parent.manager.selection
	if selection:
		animation_name = "drink_energy"
	else:
		animation_name = "drink_health"
	drink_finished = false;
	super()

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.manager.is_dead:
		return death_fall_state
	
	if drink_finished:
		if not selection: 
			parent.manager.hitpoints += 1
			parent.manager.has_health_potion = false
		else:
			parent.manager.energy = parent.manager.max_energy
			parent.manager.has_energy_potion = false
		return idle_state
	return null; 

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		drink_finished = true

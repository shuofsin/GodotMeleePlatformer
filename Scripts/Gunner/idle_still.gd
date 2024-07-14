extends State

# Can go anywhere from here
@export var idle_move_state: State
@export var attack_move_state: State
@export var attack_shoot_state: State
@export var death_fall_state: State

var rest_finished = false

func enter() -> void:
	super()
	rest_finished = false

func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_fall_state
	
	parent.velocity.y += gravity * delta
	parent.velocity.x = 0 
	parent.move_and_slide()
	
	if rest_finished:
		return idle_move_state
	if parent.manager.see_player:
		return attack_move_state
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		parent.manager.direction *= -1
		rest_finished = true

extends State

@export var idle_state: State
@export var move_state: State
@export var death_fall_state: State

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement != 0:
		parent.non_zero_movement = movement
	
	parent.sprite.flip_h = parent.non_zero_movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.manager.is_dead:
		return death_fall_state
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null

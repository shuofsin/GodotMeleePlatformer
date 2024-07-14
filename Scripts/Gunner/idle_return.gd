extends State

@export var idle_move_state: State
@export var attack_move_state: State
@export var death_fall_state: State 

func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_fall_state
	var direction = sign((parent.spawn_position - parent.global_position).x)
	parent.velocity.x = direction * move_speed
	parent.velocity.y += gravity * delta 
	parent.sprite.flip_h = direction < 0
	
	parent.move_and_slide()
	
	if direction == 0:
		return idle_move_state
	if parent.manager.see_player:
		return attack_move_state
	return null

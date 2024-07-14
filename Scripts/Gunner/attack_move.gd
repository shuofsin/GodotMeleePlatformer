extends State

# Can go to any state from here
@export var idle_still_state: State
@export var attack_shoot_state: State
@export var death_fall_state: State

func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_fall_state
	
	var direction = sign((parent.player.global_position - parent.global_position).x)
	parent.velocity.x = direction * move_speed
	parent.velocity.y += gravity * delta 
	parent.sprite.flip_h = direction < 0
	
	parent.move_and_slide()
	
	if not parent.manager.see_player:
		return idle_still_state
	
	if parent.manager.within_range:
		return attack_shoot_state
	return null

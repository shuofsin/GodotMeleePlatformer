extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var ground_attack_state: State
@export var death_fall_state: State
@export var drink_potion_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed("attack") and parent.is_on_floor():
		return ground_attack_state
	if Input.is_action_just_pressed("use") and parent.is_on_floor():
		if parent.manager.selection && parent.manager.has_energy_potion && parent.manager.energy < parent.manager.max_energy:
			return drink_potion_state
		elif not parent.manager.selection && parent.manager.has_health_potion && parent.manager.hitpoints < parent.manager.max_hitpoints:
			return drink_potion_state
	return null

func process_physics(delta: float) -> State:
	
	# Charater should still move during
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement == 0:
		return idle_state
	else:
		parent.non_zero_movement = movement
	
	parent.sprite.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.manager.is_dead:
		return death_fall_state
	
	if !parent.is_on_floor():
		return fall_state
	return null

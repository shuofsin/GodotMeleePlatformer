extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State
@export var air_attack_state: State
@export var death_fall_state: State

# Get audio
@onready var audio_jump: AudioStreamPlayer = $"../../audio/audio_jump"

# Set as a positive in inspector, then reversed during calculation
@export var jump_force: float = 900

func enter() -> void:
	super()
	parent.velocity.y = -1 * jump_force
	audio_jump.playing = true

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack") and not parent.is_on_floor():
		return air_attack_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return fall_state
	
	var movement = Input.get_axis("move_left", "move_right") * move_speed
	
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

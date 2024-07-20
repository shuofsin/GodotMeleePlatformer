extends State

@export var final_state : State
@onready var camera: Camera2D = $"../../camera"
@onready var death_message: Sprite2D = $"../../camera/Death-message"

func enter() -> void:
	super()
	parent.velocity.y = -200
	for gui_sprite in camera.get_children():
		gui_sprite.visible = false
	death_message.visible = true

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	if parent.is_on_floor():
		return final_state
	return null

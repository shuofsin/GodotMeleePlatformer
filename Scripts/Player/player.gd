class_name Player
extends CharacterBody2D

# Get animations and sprite
@onready var animations = $animations
@onready var sprite = $sprite

# Get weapon hitbox
@onready var hitbox = $Hitbox

# Get state machine 
@onready var state_machine = $state_machine

# Get player manager
@onready var manager: Node = $player_manager

# Hold direction for move -> jump
@onready var non_zero_movement: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initilize state machine
	state_machine.init(self)

# Delegate work to state machine 
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)


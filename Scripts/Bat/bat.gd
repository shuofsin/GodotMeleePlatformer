extends CharacterBody2D

# Get animations and sprite
@onready var animations = $animations
@onready var sprite = $sprite

# Get state machine 
@onready var state_machine = $state_machine

# Track detection input
@onready var player: Node2D 

# Manager
@onready var manager: Node = $bat_manager

@export var drop_chance: int = 2
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

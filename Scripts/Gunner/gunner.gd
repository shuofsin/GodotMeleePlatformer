extends CharacterBody2D

# Get animations and sprite
@onready var animations = $animations
@onready var sprite = $sprite

# Get state machine 
@onready var state_machine = $state_machine

# Track detection input
@onready var player: Node2D 

# Get gunny manager
@onready var manager: Node = $gunner_manager

# Gun location "hitbox"
@onready var hitbox: Area2D = $Hitbox

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

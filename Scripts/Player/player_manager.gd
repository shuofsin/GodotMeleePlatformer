extends Node

@onready var player: Player = $".."
@onready var hp_display: Sprite2D = $"../camera/hp_display"
@onready var energy_display: Sprite2D = $"../camera/energy_display"
@onready var health_pot_display: Sprite2D = $"../camera/health_pot_display"
@onready var energy_pot_display: Sprite2D = $"../camera/energy_pot_display"
@onready var selector_display: Sprite2D = $"../camera/selector_display"
@onready var audio_hurt: AudioStreamPlayer = $"../audio/audio_hurt"
@export var max_hitpoints: int = 3
@export var max_energy: int = 3
var selection = false
var hitpoints: int = 3
var energy: int = 0
var is_dead = false
var has_health_potion = false
var has_energy_potion = false
@onready var camera: Camera2D = $"../camera"
@onready var death_message: Sprite2D = $"../camera/Death-message"

func _ready() -> void:
	for gui_sprite in camera.get_children():
		gui_sprite.visible = true
	death_message.visible = false

func _process(delta: float) -> void:
	render_hud()
	if hitpoints <= 0:
		is_dead = true

func render_hud() -> void: 
	hp_display.frame = hitpoints
	energy_display.frame = energy
	health_pot_display.frame = has_health_potion
	energy_pot_display.frame = has_energy_potion
	selector_display.frame = selection

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		selection = not selection

func _on_hurtbox_area_entered(area: Area2D) -> void:
	player.sprite.material.set_shader_parameter("active", true)
	hitpoints -= 1 
	audio_hurt.playing = true
	if area.collision_layer == 256:
		area.delete = true
	
func _on_hurtbox_area_exited(area: Area2D) -> void:
	player.sprite.material.set_shader_parameter("active", false)

func _on_boundry_box_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()

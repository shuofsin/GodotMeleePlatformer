extends State

@export var fall_state: State
@export var death_fall_state: State
@onready var animations: AnimationPlayer = $"../../animations"

var attack_finished = false 
@export var fire_projectile: bool = false

func enter() -> void: 
	super()
	attack_finished = false 
	fire_projectile = false

func process_physics(delta: float) -> State:
	shoot_projectile()
	parent.velocity.y = 0
	parent.velocity.x /= 1.2
	parent.move_and_slide()
	
	if parent.manager.is_dead:
		return death_fall_state
	
	if attack_finished:
		return fall_state
	
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		attack_finished = true

func shoot_projectile() -> void:
	if parent.manager.energy > 0 && fire_projectile:
		var new_projectile = load("res://Scenes/AirProjectile.tscn").instantiate()
		new_projectile.global_position = parent.hitbox.global_position
		new_projectile.transform.x = parent.hitbox.transform.x
		get_tree().current_scene.add_child(new_projectile)
		parent.manager.energy -= 1
		fire_projectile = false

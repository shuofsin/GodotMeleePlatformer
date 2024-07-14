extends State

@export var idle_state: State
@export var move_state: State
@export var death_fall_state: State

var attack_finished = false

@export var fire_projectile: bool = false

func enter() -> void:
	super()
	attack_finished = false
	fire_projectile = false
	
func process_physics(delta: float) -> State:
	shoot_projectile()
	parent.velocity.y += gravity * delta
	
	if parent.manager.is_dead:
		return death_fall_state
	
	if attack_finished:
		if parent.velocity.x == 0:
			return idle_state
		else:
			return move_state
	return null 

func _on_animations_animation_finished(anim_name: String) -> void:
	if anim_name == animation_name:
		attack_finished = true

func shoot_projectile() -> void:
	if parent.manager.energy > 0 && fire_projectile:
		var new_projectile = load("res://Scenes/GroundProjectile.tscn").instantiate()
		new_projectile.global_position = parent.hitbox.global_position
		new_projectile.transform.x = parent.hitbox.transform.x
		get_tree().current_scene.add_child(new_projectile)
		parent.manager.energy -= 1
		fire_projectile = false

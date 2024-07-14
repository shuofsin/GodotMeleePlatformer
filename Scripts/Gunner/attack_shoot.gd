extends State

# Can go to any state
@export var idle_still_state: State
@export var attack_shoot_state: State
@export var attack_move_state: State
@export var death_fall_state: State

var shoot_finished = false
@export var fired = true

func enter() -> void:
	super()
	shoot_finished = true
	fired = true

func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_fall_state
	
	parent.velocity.x = 0
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	shoot_projectile()
	
	if shoot_finished:
		if parent.manager.within_range:
			return attack_shoot_state 
		if parent.manager.see_player:
			return attack_move_state
		return idle_still_state
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		shoot_finished = true

func shoot_projectile() -> void:
	if not fired: 
		var new_projectile = load("res://Scenes/GunnerProjectile.tscn").instantiate()
		new_projectile.global_position = parent.hitbox.global_position
		new_projectile.transform.x = parent.hitbox.transform.x
		get_tree().current_scene.add_child(new_projectile)
		fired = true

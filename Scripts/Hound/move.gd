extends State

@export var idle_state: State
@export var attack_state: State
@export var death_state: State 

var within_attack_range = false

func enter() -> void:
	super()
	within_attack_range = false

func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_state
	
	var direction = sign((parent.player.global_position - parent.global_position).x)
	parent.velocity.x = direction * move_speed
	parent.velocity.y += gravity * delta 
	parent.sprite.flip_h = direction < 0
	
	parent.move_and_slide()
	
	if within_attack_range:
		return attack_state
	
	return null


func _on_attack_box_area_entered(area: Area2D) -> void:
	within_attack_range = true

extends State 

@export var move_state: State 
@export var attack_state: State 
@export var death_state: State 

var found_player = false
var within_attack_range = false

func enter() -> void:
	super()
	parent.velocity.x = 0
	found_player = false
	within_attack_range = false

func process_physics(delta: float) -> State:
	if parent.manager.is_dead:
		return death_state
	
	parent.velocity.y += gravity * delta 
	parent.move_and_slide()
	
	if found_player:
		return move_state
	
	if within_attack_range:
		return attack_state
	
	return null

func _on_detectbox_area_entered(area: Area2D) -> void:
	found_player = true
	parent.player = area.get_parent()


func _on_attack_box_area_entered(area: Area2D) -> void:
	within_attack_range = true
	parent.player = area.get_parent()

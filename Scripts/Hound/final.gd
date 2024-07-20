extends State

@export var chance: int = 1

func enter() -> void:
	super()
	randomize()

func process_physics(delta: float) -> State:
	parent.velocity.x /= 1.2
	parent.move_and_slide()
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		parent.queue_free()
		get_tree().change_scene_to_file("res://Scenes/closing.tscn")

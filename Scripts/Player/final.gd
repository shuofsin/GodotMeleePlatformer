extends State

@onready var audio_death: AudioStreamPlayer = $"../../audio/audio_death"

func enter() -> void:
	super()
	audio_death.playing = true

func process_physics(delta: float) -> State:
	parent.velocity.x /= 1.2
	parent.move_and_slide()
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		get_tree().reload_current_scene()

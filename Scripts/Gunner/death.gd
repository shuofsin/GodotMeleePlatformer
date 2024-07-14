extends State

func enter() -> void:
	super()
	randomize()

func process_physics(delta: float) -> State:
	parent.velocity.x /= 1.2
	parent.move_and_slide()
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		print("animation_finished")
		spawn_potion()
		parent.queue_free()

func spawn_potion() -> void: 
	if (randi() % parent.drop_chance) == (parent.drop_chance - 1):
		var new_potion = load("res://Scenes/EnergyPotion.tscn").instantiate()
		new_potion.global_position = parent.global_position
		add_child(new_potion)
		new_potion.reparent(get_tree().root, false)

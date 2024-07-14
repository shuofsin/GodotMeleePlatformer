extends State

# Die
func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		drop_item()
		parent.queue_free()

func drop_item() -> void:
	if (randi() % parent.drop_chance) == (parent.drop_chance - 1):
		var new_potion = load("res://Scenes/HealthPotion.tscn").instantiate()
		new_potion.global_position = parent.global_position
		add_child(new_potion)
		new_potion.reparent(get_tree().root, false)

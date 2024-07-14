extends Node

# Spawn an energy potion
func _ready() -> void:
	var chance = 5
	if (randi() % chance) == (chance - 1):
			var new_potion = load("res://Scenes/EnergyPotion.tscn").instantiate()
			new_potion.global_position = self.global_position
			add_child(new_potion)
			new_potion.reparent(get_tree().root, false)

extends Button

func _on_pressed():
	GameState.reset_game()
	get_tree().change_scene_to_file("res://scenes/outdoors/outdoors.tscn")

extends Node

const STARVING_FACTOR = 2

func _on_timeout():
	GameState.score -= STARVING_FACTOR
	if (GameState.score <= 0):
		print("death by starving")
		get_tree().change_scene_to_file("res://scenes/gameover/gameover.tscn")

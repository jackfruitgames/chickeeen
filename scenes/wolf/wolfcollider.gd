extends Area2D

func _on_body_entered(collided_object):
	if collided_object.is_in_group("player"):
		print("dead by wolf")
		get_tree().change_scene_to_file("res://scenes/gameover/gameover.tscn")

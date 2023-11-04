extends Area2D

func _on_body_entered(collided_object):
	if collided_object.is_in_group("player"):
		GameState.score += 10
		print("score: " + str(GameState.score))
		$EatAudioStreamPlayer2D.play()

	# destroy food if it is spawned random inside a tree or some other object
	queue_free()

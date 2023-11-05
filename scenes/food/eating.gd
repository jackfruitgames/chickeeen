extends Area2D

const FOOD_FACTOR_PER_CORN = 40

func _on_body_entered(collided_object):
	if collided_object.is_in_group("player"):
		GameState.score += FOOD_FACTOR_PER_CORN
		print("score: " + str(GameState.score))
		$EatAudioStreamPlayer2D.play()

		if (GameState.score > GameState.MAX_EATING_SCORE):
			GameState.level += 1
			GameState.score = GameState.INITIAL_SCORE

		if GameState.level > 3:
			GameState.has_sprint = true
			
	# destroy food if it is spawned random inside a tree or some other object
	queue_free()

extends Area2D

func _on_body_entered(body):
	GameState.score += 10
	print("score: " + str(GameState.score))
	$EatAudioStreamPlayer2D.play()
	queue_free()

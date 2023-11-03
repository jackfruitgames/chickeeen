extends Area2D

func _on_body_entered(body):
	GameState.score += 1
	print("score: " + str(GameState.score))
	queue_free()

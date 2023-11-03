extends Timer


func _on_timeout():
	if (GameState.seconds_until_night <= 0):
		GameState.seconds_until_night = GameState.SECONDS_BETWEEN_NIGHTS
	GameState.seconds_until_night -= 1
	print("seconds until night: " + str(GameState.seconds_until_night))

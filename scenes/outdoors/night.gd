extends Timer

func _on_timeout():
	GameState.day_duration -= 1  # day is always progressing
	if (GameState.day_duration <= 0):
		GameState.day_duration = GameState.DAY_DURATION
		GameState.is_night = !GameState.is_night

	if (GameState.dawn_time <= 0):
		GameState.dawn_time = GameState.DAWN_TIME

	if (GameState.day_duration <= GameState.DAWN_TIME):
		GameState.dawn_time -= 1
		GameState.is_dawn = true

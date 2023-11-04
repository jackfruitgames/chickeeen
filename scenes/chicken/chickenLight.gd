extends PointLight2D

func _process(delta):
	var night_progress = float(GameState.dawn_time) / float(GameState.DAWN_TIME)

	if GameState.is_night:
		night_progress = 1 - night_progress
	energy = 1 - night_progress

extends CanvasModulate

func _process(delta):
	var night_progress = float(GameState.dawn_time) / float(GameState.DAWN_TIME)
	if GameState.is_night:
		night_progress = 1 - night_progress
	color = Color(night_progress, night_progress, night_progress, 1)

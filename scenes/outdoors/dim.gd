extends CanvasModulate

func _process(_delta:float):
	var night_progress = float(GameState.dawn_time) / float(GameState.DAWN_TIME)
	if GameState.is_night:
		night_progress = 1 - night_progress
	
	if !GameState.has_torch && night_progress < 0.1:
		night_progress = 0.1  # do not turn off light completely  
			
	color = Color(night_progress, night_progress, night_progress, 1)

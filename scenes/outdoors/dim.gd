extends CanvasModulate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var night_progress = float(GameState.seconds_until_night) / float(GameState.SECONDS_BETWEEN_NIGHTS)
	color = Color(night_progress, night_progress, night_progress, 1)

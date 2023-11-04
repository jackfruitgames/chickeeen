extends Label

func _process(delta):
	# spaces are a hacky way for padding. TODO: Find a better solution :)
	text = str(GameState.level) + "    "

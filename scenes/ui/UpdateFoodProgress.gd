extends ProgressBar

func _process(delta):
	value = GameState.score
	
	if value <= 20:
		var sb = StyleBoxFlat.new()
		add_theme_stylebox_override("fill", sb)
		sb.bg_color = Color("ff0000")
	else:
		var sb = StyleBoxFlat.new()
		add_theme_stylebox_override("fill", sb)
		sb.bg_color = Color("ffffff")

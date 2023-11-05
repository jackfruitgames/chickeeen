extends Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.has_swimmer:
		visible = true
	else:
		visible = false

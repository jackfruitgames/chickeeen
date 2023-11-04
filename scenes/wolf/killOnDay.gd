extends Node

func _process(delta):
	if not GameState.is_night:
		get_parent().queue_free()

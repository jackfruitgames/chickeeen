extends Node

func _process(_delta:float):
	if not GameState.is_night:
		get_parent().queue_free()

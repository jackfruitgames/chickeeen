extends Node2D

func _ready():
	# prevent wolfes from disappearing
	GameState.is_night = true

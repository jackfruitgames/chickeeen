extends Node2D

func _ready():
	# prevent wolfes from disappearing
	GameState.is_night = true
	GameState.level = 10
	GameState.has_shotgun = true
	GameState.ammo = 100

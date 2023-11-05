extends AudioStreamPlayer


const DAY_MUSIC := preload("res://assets/music/road-to-paris-gypsy-jazz-144631.mp3")
const NIGHT_MUSIC := preload("res://assets/music/Scary Ambient Wind.mp3")

var day_music_stopped := false
var is_night := false

func _process(_delta:float):
	if GameState.is_dawn && !day_music_stopped:
		day_music_stopped = true
		volume_db = -30
	if GameState.is_night && !is_night:
		stop()
		stream = NIGHT_MUSIC
		is_night = true
		volume_db = -5
		play()
	if !GameState.is_night && is_night:
		is_night = false
		stop()
		stream = DAY_MUSIC
		volume_db = -20
		play()

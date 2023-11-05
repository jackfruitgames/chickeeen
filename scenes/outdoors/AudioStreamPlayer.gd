extends AudioStreamPlayer


var day_music := preload("res://assets/music/road-to-paris-gypsy-jazz-144631.mp3")
var night_music := preload("res://assets/music/Scary Ambient Wind.mp3")

var day_music_stopped := false
var is_night := false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.is_dawn && !day_music_stopped:
		day_music_stopped = true
		volume_db = -30
	if GameState.is_night && !is_night:
		stop()
		stream = night_music
		is_night = true
		volume_db = -5
		play()
	if !GameState.is_night && is_night:
		is_night = false
		stop()
		stream = day_music
		volume_db = -20
		play()

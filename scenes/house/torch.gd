extends PointLight2D

@onready var noise = FastNoiseLite.new()
var rng = RandomNumberGenerator.new()

var time_passed = rng.randf_range(0.0, 10.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed += delta
	var flicker_noise = abs(noise.get_noise_1d(time_passed * 10)) * 2 + 1
	var night_progress = float(GameState.dawn_time) / float(GameState.DAWN_TIME)
	if GameState.is_night:
		night_progress = 0
	energy = flicker_noise * (1 - night_progress)

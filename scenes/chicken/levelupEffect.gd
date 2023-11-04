extends GPUParticles2D

var current_level := GameState.level

func _process(delta):
	if GameState.level > current_level:
		emitting = true
		current_level = GameState.level

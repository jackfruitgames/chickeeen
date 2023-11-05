extends GPUParticles2D

var current_level := GameState.level

func _process(_delta:float):
	if GameState.level > current_level:
		emitting = true
		current_level = GameState.level

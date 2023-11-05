extends Node

const DYING_WOLF = preload("res://scenes/wolf/dyingWolf.tscn")

func _process(_delta:float):
	if not GameState.is_night:
		var dying_animation = DYING_WOLF.instantiate()
		dying_animation.position = get_parent().position
		get_tree().get_root().call_deferred("add_child", dying_animation)
		dying_animation.get_node("GPUParticles2D").emitting = true
		get_parent().queue_free()

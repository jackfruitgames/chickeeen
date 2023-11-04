extends Sprite2D


func _ready():
	$AnimationPlayer.play("lantern_swing")


func _process(delta):
	if GameState.has_torch && GameState.is_dawn:
		visible = true
	else:
		visible = false

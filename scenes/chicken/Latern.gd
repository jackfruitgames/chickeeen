extends Sprite2D


func _ready():
	$AnimationPlayer.play("lantern_swing")


func _process(_delta:float):
	visible = GameState.has_torch && GameState.is_dawn

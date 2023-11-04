extends Area2D

var chicken_is_on_matress := false
var night_skipped := false

func _process(delta):
	if chicken_is_on_matress:
		if Input.is_action_just_pressed("lay_egg"):
			if GameState.score >= 40:
				GameState.eggs += 1
				GameState.score -= 25
		elif Input.is_action_just_pressed("sleep") && !night_skipped:
			print("sleep")
			GameState.score -= 10
			night_skipped = true
			GameState.skip_night()

func _on_body_entered(body):
	chicken_is_on_matress = true
	$CanvasLayer.visible = true

func _on_body_exited(body):
	chicken_is_on_matress = false
	$CanvasLayer.visible = false

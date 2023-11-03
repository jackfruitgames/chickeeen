extends Area2D


func _on_body_entered(body):
	print("dead by wolf")
	GameState.score = 0

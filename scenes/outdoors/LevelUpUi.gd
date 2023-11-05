extends CanvasLayer

var level_up_features := [
	"increase speed",
	"more speed",
	"ultra speed",
	"unlock sprint [space]",\
	"sprint faster [space]",
	"sprint ULTRAFAST [space]"
]


func _process(_delta:float):
	if GameState.level_up:
		GameState.level_up = false
		get_tree().paused = true
		if level_up_features.size() > (GameState.level - 1):
			$ColorRect/LevelUpDetails.text = "Level Up: " + level_up_features[(GameState.level - 1)]
		else:
			$ColorRect/LevelUpDetails.text = "Level up: ???"
		visible = true


func _on_level_up_button_pressed():
	GameState.level += 1
	continue_game()


func _on_lay_egg_button_pressed():
	GameState.eggs += 1
	continue_game()
	

func continue_game():
	GameState.score = GameState.INITIAL_SCORE
	get_tree().paused = false
	visible = false
	

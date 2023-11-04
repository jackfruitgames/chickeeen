extends Area2D


var chicken_is_on_vendor := false
var og_text := "Buy Torch?\nE: Confirm"

func has_enough_eggs():
	return GameState.eggs >= 2

func _process(delta):
	if chicken_is_on_vendor:
		if Input.is_action_just_pressed("lay_egg") && has_enough_eggs():
			GameState.eggs -= 2
			GameState.has_torch = true
			print("Chicken now has torch!")

func _on_body_entered(body):
	if body.is_in_group("player"):
		chicken_is_on_vendor = true
		$BuyConfirm.visible = true
		if !has_enough_eggs():
			$BuyConfirm/Label.text = "Not enough money!"
		else:
			$BuyConfirm/Label.text = og_text
		


func _on_body_exited(body):
	if body.is_in_group("player"):
		chicken_is_on_vendor = true
		$BuyConfirm.visible = false

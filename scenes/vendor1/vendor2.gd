extends Area2D

const OG_TEXT := "Buy SHOTGUN?\nE: Confirm"
var chicken_is_on_vendor := false

func has_enough_eggs():
	return GameState.eggs >= 10

func _process(_delta:float):
	if chicken_is_on_vendor:
		if Input.is_action_just_pressed("lay_egg") && has_enough_eggs():
			GameState.eggs -= 10
			GameState.has_shotgun = true
			GameState.ammo = 5
			print("Chicken now has SHOTGUN!")

func _on_body_entered(body):
	if body.is_in_group("player"):
		chicken_is_on_vendor = true
		$BuyConfirm.visible = true
		if !has_enough_eggs():
			$BuyConfirm/Label.text = "Not enough eggs!"
		else:
			$BuyConfirm/Label.text = OG_TEXT

func _on_body_exited(body):
	if body.is_in_group("player"):
		chicken_is_on_vendor = true
		$BuyConfirm.visible = false

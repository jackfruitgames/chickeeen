extends HBoxContainer

func _process(_delta:float):
	if GameState.has_swimmer:
		$Swimmer.visible = true
		$SwimmerP.visible = false

	if GameState.has_torch:
		$Lantern.visible = true
		$LanternP.visible = false

	if GameState.has_shotgun:
		$Shotgun.visible = true
		$AmmoContainer.visible = true
		$ShotgunP.visible = false

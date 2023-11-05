extends HBoxContainer

func _process(_delta:float):
	if GameState.has_swimmer:
		$Swimmer.visible = true

	if GameState.has_torch:
		$Lantern.visible = true

	if GameState.has_shotgun:
		$Shotgun.visible = true
		$AmmoContainer.visible = true

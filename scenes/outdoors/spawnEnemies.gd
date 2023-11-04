extends Timer

const BASE_NUMBER_OF_ENEMIES := 5

const MAX_X := 500
const MAX_Y := 500
const WOLF := preload("res://scenes/wolf/wolf.tscn")

func spawn_some_enemies():
	var number_of_enemies = BASE_NUMBER_OF_ENEMIES
	print("spawn enemies...")
	for i in number_of_enemies:
		var wolf_instance = WOLF.instantiate()

		var rng := RandomNumberGenerator.new()
		var pos_x = rng.randi_range(0, MAX_X)
		var pos_y = rng.randi_range(0, MAX_Y)

		wolf_instance.position = Vector2(pos_x, pos_y)
		get_parent().call_deferred("add_child", wolf_instance)

func _on_timeout():
	if (GameState.is_night):
		spawn_some_enemies()

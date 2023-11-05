extends Timer

const BASE_NUMBER_OF_ENEMIES := 5

var rng = RandomNumberGenerator.new()

const MAX_X := 500
const MAX_Y := 500
const WOLF := preload("res://scenes/wolf/wolf.tscn")

func spawn_some_enemies(n_enemies: int):
	var number_of_enemies = BASE_NUMBER_OF_ENEMIES
	print("spawn enemies...")
	for i in n_enemies:
		var wolf_instance = WOLF.instantiate()

		var rng := RandomNumberGenerator.new()
		var pos_x = rng.randi_range(0, MAX_X)
		var pos_y = rng.randi_range(0, MAX_Y)

		wolf_instance.position = Vector2(pos_x, pos_y)
		get_parent().call_deferred("add_child", wolf_instance)

func _on_timeout():
	var num := rng.randi_range(0, 2)
	if GameState.is_dawn && num == 2:
		print("spwawning early wolf")
		spawn_some_enemies(1)
		
	if (GameState.is_night):
		spawn_some_enemies(BASE_NUMBER_OF_ENEMIES)

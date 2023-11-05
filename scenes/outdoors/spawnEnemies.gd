extends Timer

const BASE_NUMBER_OF_ENEMIES := 15
const HOUSE_POSITION := Vector2(200, 200)

var rng = RandomNumberGenerator.new()

const MAX_X := 500
const MAX_Y := 500
const WATER_TILE_TERRAIN := 2
const WOLF := preload("res://scenes/wolf/wolf.tscn")

const CENTER = Vector2(200, 200)

func area_aware_position() -> Vector2:
	var pos_y = 1000.0 - abs(rng.randfn(0.0, 500.0))
	var pos_x = 1400.0 - abs(rng.randfn(0.0, 700.0))
	
	if rng.randi_range(0, 1) == 0:
		pos_x *= -1
#
	if rng.randi_range(0, 1) == 0:
		pos_y *= -1
	
	return Vector2(pos_x, pos_y) + CENTER
	
func get_valid_position() -> Vector2:
	var vec = area_aware_position()
	
	var player = $%chicken
	var map: TileMap = $%Map
	if !map:
		return vec
		
	var n_retries = 10
	
	while n_retries >= 0:
		n_retries -+ 1

		var tile := map.local_to_map(vec)
		var data = map.get_cell_tile_data(0, tile)
		
		vec = area_aware_position()
		
		if !data:
			continue
		
		if data.terrain == WATER_TILE_TERRAIN:
			continue  # don't spawn wolf on water
			
		if player.global_position.distance_to(vec) < 50:
			vec.x += 50	
			vec.y += 50
			
		return vec
		
	print("Wolf might have invalid position!")
	return vec  # well we failed, let's just return the vector

func spawn_some_enemies(n_enemies: int):
	var number_of_enemies = BASE_NUMBER_OF_ENEMIES
	for i in n_enemies:
		var wolf_instance = WOLF.instantiate()
		var position = get_valid_position()
		print("Spawning wolf at: ", position)
		wolf_instance.position = position
		get_parent().call_deferred("add_child", wolf_instance)

func _on_timeout():
	var num = rng.randi_range(0, 2)
	if GameState.is_dawn && num == 2:
		print("spwawning early wolf")
		spawn_some_enemies(1)
		
	num = rng.randi_range(0, 1)
	if GameState.is_night && num == 1:
		spawn_some_enemies(BASE_NUMBER_OF_ENEMIES)

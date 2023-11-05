extends Timer

const BASE_NUMBER_OF_ENEMIES := 10
const HOUSE_POSITION := Vector2(200, 200)

var rng = RandomNumberGenerator.new()

const MAX_X := 500
const MAX_Y := 500
const WATER_TILE_TERRAIN := 2
const WOLF := preload("res://scenes/wolf/wolf.tscn")

const TOP_LEFT := Vector2(-150, -50)
const BOTTOM_RIGHT := Vector2(550, 500)


func area_aware_position() -> Vector2:
	var pos_x = rng.randi_range(TOP_LEFT.x, BOTTOM_RIGHT.x)
	var pos_y = rng.randi_range(TOP_LEFT.y, BOTTOM_RIGHT.y)
	
	var area = rng.randi_range(0, 10)
	
	if area >= 2:
		var offset_x = rng.randi_range(0, 300)
		var offset_y = rng.randi_range(0, 300)
		
		if area > 5:
			offset_x = rng.randi_range(300, 600)
			offset_y = rng.randi_range(300, 600)
		
		if pos_x > 0:
			pos_x += offset_x
		else:
			pos_x -= offset_x
			
		if pos_y > 0:	
			pos_y += offset_y
		else:
			pos_y -= offset_y
	
	return Vector2(pos_x, pos_y)
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

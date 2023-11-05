extends Node2D

var NUMBER_OF_FOOD := 1000

var FOOD := preload("res://scenes/food/food.tscn")
var rng = RandomNumberGenerator.new()

const WATER_TILE_TERRAIN := 2

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
		n_retries -= 1

		var tile := map.local_to_map(vec)
		var data = map.get_cell_tile_data(0, tile)
		if !data:
			continue
		
		vec = area_aware_position()
	
		if data.terrain == WATER_TILE_TERRAIN:
			continue  # don't spawn wolf on water
			
		if player.global_position.distance_to(vec) < 50:
			vec.x += 50	
			vec.y += 50
			
		return vec
		
	print("Food might have invalid position!")
	return vec  # well we failed, let's just return the vector

func spawn_some_foods():
	for i in NUMBER_OF_FOOD:
		var food_instance = FOOD.instantiate()
		var position = get_valid_position()
		print("Spawning food at: ", position)
		food_instance.position = position
		get_parent().call_deferred("add_child", food_instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_some_foods()

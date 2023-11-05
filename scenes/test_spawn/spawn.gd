extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_some_foods()

var NUMBER_OF_FOOD := 1000

var FOOD := preload("res://scenes/food/food.tscn")
var rng = RandomNumberGenerator.new()

const WATER_TILE_TERRAIN := 2

const CENTER := Vector2(200, 200)

const WORLD_TOP_LEFT = Vector2(-750, -1000)
const WORLD_BOTTOM_RIGHT = Vector2(1700, 1050)

func area_aware_position() -> Vector2:
	var pos_y = 500.0 - abs(rng.randfn(0.0, 250.0))
	var pos_x = 600.0 - abs(rng.randfn(0.0, 300.0))
	
	if rng.randi_range(0, 1) == 0:
		pos_x *= -1
#
	if rng.randi_range(0, 1) == 0:
		pos_y *= -1

#	pos_y *= -1
#	pos_x *= -1
		
#	if pos_y > 0:
#		pos_y = 600.0 - pos_y
#	else:
#		pos_y = 600.0 + pos_y
#	else:
#		if pos_x > 0:
#			pos_x = 500.0 + pos_x
#		else:
#			pos_x = 500.0 - pos_x
#
#		if pos_y > 0:
#			pos_y = 600.0 + pos_y
#		else:
#			pos_y = 600.0 - pos_y
#
#		pos_x -= 500 * 2
#		pos_y -= 600 * 2
		
#	if rng.randi_range(0, 1) == 0:
##		if pos_x < 500.0:
#		pos_x *= -1
#
##		if pos_y < 600.0:
#		pos_y *= -1

#	if rng.randi_range(0, 1) == 0:
#		pos_y *= -1
#		pos_x *= -1
	
	var vec = Vector2(pos_x, pos_y)
	print("VEC: ", vec)
	
#	if area >= 1:
#		var offset_x = rng.randi_range(0, 300)
#		var offset_y = rng.randi_range(0, 300)
#
#		if area > 10:
#			offset_x = rng.randi_range(300, 1500)
#			offset_y = rng.randi_range(300, 1500)
#
#		if pos_x > 0:
#			pos_x += offset_x
#		else:
#			pos_x -= offset_x
#
#		if pos_y > 0:	
#			pos_y += offset_y
#		else:
#			pos_y -= offset_y
	
	return vec
	
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
		#print("Spawning food at: ", position)
		food_instance.position = position
		get_parent().call_deferred("add_child", food_instance)

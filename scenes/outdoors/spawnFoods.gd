extends Node2D

var NUMBER_OF_FOOD := 200

var MAX_X := 1000
var MAX_Y := 700
var FOOD := preload("res://scenes/food/food.tscn")

func spawn_some_foods():
	for i in NUMBER_OF_FOOD:
		var food_instance = FOOD.instantiate()

		var rng := RandomNumberGenerator.new()
		var pos_x = rng.randi_range(0, MAX_X)
		var pos_y = rng.randi_range(0, MAX_Y)

		food_instance.position = Vector2(pos_x, pos_y)
		get_parent().call_deferred("add_child", food_instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_some_foods()

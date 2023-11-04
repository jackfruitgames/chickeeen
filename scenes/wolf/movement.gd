extends NavigationAgent2D

const SPEED := 1000

var player = null
var wolf = null

func _ready():
	player = get_tree().get_root().get_node_or_null("/root/outdoors/chicken")
	var nav_map = get_tree().get_root().get_node_or_null("/root/outdoors/Map")
	if nav_map:
		set_navigation_map(nav_map)
	wolf = get_parent()
	if player:
		print("set target")
		target_position = player.global_position

func _physics_process(delta):
	if not is_navigation_finished() and player:
		target_position = player.global_position
		print("target player at " + str(target_position))
		var next_direction = get_next_path_position()
		print("next_direction: " + str(next_direction))
		var current_enemy_position = wolf.global_position
		var target_direction = (next_direction - current_enemy_position).normalized()
		wolf.velocity = target_direction * (SPEED * delta)
		wolf.move_and_slide()

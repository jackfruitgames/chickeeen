extends NavigationAgent2D

const SPEED := 300

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
		if distance_to_target() < 200:
			var next_direction = get_next_path_position()
			var current_enemy_position = wolf.global_position
			var target_direction = (next_direction - current_enemy_position).normalized()
			wolf.velocity = target_direction * (SPEED * delta)
			wolf.move_and_slide()
		for i in wolf.get_slide_collision_count():
			var collision = wolf.get_slide_collision(i)
			if collision.get_collider().is_in_group("player"):
				print("Death by wolf: ", collision.get_collider().name)
				get_tree().change_scene_to_file("res://scenes/gameover/gameover.tscn")

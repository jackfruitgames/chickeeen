extends NavigationAgent2D

var rng = RandomNumberGenerator.new()

const SPEED := 2000
const REACH_DISTANCE = 200

var player = null
var wolf = null

func _ready():
	player = get_tree().get_root().get_node_or_null("/root/outdoors/chicken")
	wolf = get_parent()
	if not player:
		player = get_tree().get_root().get_node_or_null("/root/testscene/chicken")
	if player:
		print("wolf did set target to player")
		target_position = player.global_position

func _physics_process(delta):
	if not is_navigation_finished() and player:
		target_position = player.global_position
		if distance_to_target() < REACH_DISTANCE:
			var next_direction = get_next_path_position()
			var current_enemy_position = wolf.global_position
			var target_direction = (next_direction - current_enemy_position).normalized()
			wolf.velocity = target_direction * ((SPEED + rng.randi_range(100, 2000)) * delta)
			get_parent().get_node("Sprite2D").flip_h = target_direction.x < 0
			get_parent().get_node("PointLight2DLeft").visible = target_direction.x < 0
			get_parent().get_node("PointLight2D").visible = not target_direction.x < 0
			wolf.move_and_slide()

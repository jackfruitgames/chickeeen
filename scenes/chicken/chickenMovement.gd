extends CharacterBody2D

var speed: float = 2500.0
var sprinting: bool = false
var map: TileMap = null
var original_speed: float = 0

const WATER_TILE_TERRAIN: int = 2
const SWIMMING = preload("res://assets/chicken/Chicken-half.png")
const NORMAL = preload("res://assets/chicken/Chicken-0001.png")


func _ready():
	map = get_tree().get_root().get_node_or_null("/root/outdoors/Map")
	if get_parent().name == "house":
		speed = 5000


func _process(_delta: float):
	if not map:
		return

	var tile := map.local_to_map(get_position())
	var data = map.get_cell_tile_data(0, tile)

	if data.terrain == WATER_TILE_TERRAIN && GameState.has_swimmer:
		# chicken is in water
		GameState.is_in_water = true
		$Sprite2D/AnimationPlayer.play("Swimming")
	else:
		GameState.is_in_water = false

func _physics_process(delta: float):
	var real_speed = speed * delta * (clamp(GameState.level, 1, 3) * 0.5)
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if GameState.is_in_water:
		real_speed = speed * delta  # chicken is slower in water

	velocity = input_direction * real_speed
	if input_direction != Vector2(0, 0):
		$Sprite2D/AnimationPlayer.play("Walking")
		if !$WalkAudioStreamPlayer2D.playing:
			$WalkAudioStreamPlayer2D.play()
		$Sprite2D.flip_h = input_direction.x < 0
		$Sprite2D/Shotgun.flip_h = input_direction.x < 0
	else:
		$Sprite2D/AnimationPlayer.play("Idle")

	# sprint
	if Input.is_action_just_pressed("sprint") && !sprinting && GameState.has_sprint:
		sprinting = true
		original_speed = speed
		speed = speed * ((clamp(GameState.level, 4, 6) - 2) * 0.5)
		$ChickeeenAudioStreamPlayer2D.play()
		$AnimationPlayer.stop()
		$AnimationPlayer.play("backflip")
		$SprintTimer.start()

	move_and_slide()


func _on_sprint_timer_timeout():
	$SprintTimer.stop()
	sprinting = false
	speed = original_speed
	$AnimationPlayer.stop()
	$AnimationPlayer.play("chicken_default")

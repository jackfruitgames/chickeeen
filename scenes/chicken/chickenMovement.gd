extends CharacterBody2D

var speed = 25.0
var sprinting := false
const WATER_TILE_TERRAIN := 2

const SWIMMING = preload("res://assets/chicken/Chicken-half.png")
const NORMAL = preload("res://assets/chicken/Chicken-0001.png")


func _ready():
	if get_parent().name == "house":
		speed = 50

func _process(delta):
	var map: TileMap = $%Map
	var tile := map.local_to_map(get_position())
	var data = map.get_cell_tile_data(0, tile)
	
	if data.terrain == WATER_TILE_TERRAIN:
		# chicken is in water
		GameState.is_in_water = true
		$Sprite2D/Swimmer.visible = true
		$Sprite2D.texture = SWIMMING
	else:
		GameState.is_in_water = false
		$Sprite2D/Swimmer.visible = false
		$Sprite2D.texture = NORMAL

	
func _physics_process(delta):
	var real_speed = speed * clamp(GameState.level, 1, 3)
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
	if GameState.is_in_water:
		real_speed = speed  # chicken is slower in water
	
	velocity = input_direction * real_speed
	if input_direction != Vector2(0, 0):
		if !$WalkAudioStreamPlayer2D.playing:
			$WalkAudioStreamPlayer2D.play()
		$Sprite2D.flip_h = input_direction.x < 0
		
	# sprint
	if Input.is_action_just_pressed("sprint") && !sprinting && GameState.has_sprint:
		sprinting = true
		speed = speed * 2
		$AnimationPlayer.stop()
		$AnimationPlayer.play("backflip")
		$SprintTimer.start()

	move_and_slide()#returns an array of all cell indexes that contain a chess piece (0,1, 0,2, etc)


func _on_sprint_timer_timeout():
	$SprintTimer.stop()
	sprinting = false
	speed = speed / 2
	$AnimationPlayer.stop()
	$AnimationPlayer.play("chicken_default")

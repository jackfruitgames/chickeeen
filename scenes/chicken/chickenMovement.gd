extends CharacterBody2D

var speed = 25.0

func _ready():
	if get_parent().name == "house":
		speed = 50

func _physics_process(delta):
	var real_speed = speed * clamp(GameState.level, 1, 3)
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * real_speed
	if input_direction != Vector2(0, 0):
		if !$WalkAudioStreamPlayer2D.playing:
			$WalkAudioStreamPlayer2D.play()
		$Sprite2D.flip_h = input_direction.x < 0

	move_and_slide()

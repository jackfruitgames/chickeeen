extends CharacterBody2D

const SPEED = 25.0

func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	if input_direction != Vector2(0, 0):
		if !$WalkAudioStreamPlayer2D.playing:
			$WalkAudioStreamPlayer2D.play()
		$Sprite2D.flip_h = input_direction.x < 0

	move_and_slide()

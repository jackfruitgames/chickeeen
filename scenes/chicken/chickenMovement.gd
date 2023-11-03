extends CharacterBody2D

const SPEED = 25.0

func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED

	move_and_slide()

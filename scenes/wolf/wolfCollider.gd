extends CollisionShape2D

func _physics_process(_delta:float):
	var wolf : CharacterBody2D = get_parent()
	for i in wolf.get_slide_collision_count():
		var collision = wolf.get_slide_collision(i)
		if collision.get_collider().is_in_group("player"):
			print("Death by wolf")
			get_tree().change_scene_to_file("res://scenes/gameover/gameover.tscn")

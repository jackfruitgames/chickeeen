extends Area2D

func _ready():
	if GameState.has_swimmer:
		visible = false
		
		var body = get_parent().get_node("chicken")
		# allow the chicken to swim (not collide with water)
		# starting from level 5
		body.set_collision_layer_value(4, false)
		body.set_collision_mask_value(4, false)

func _on_body_entered(body):
	if body.is_in_group("player"):
		GameState.has_swimmer = true
		visible = false
		
		# allow the chicken to swim (not collide with water)
		# starting from level 5
		body.set_collision_layer_value(4, false)
		body.set_collision_mask_value(4, false)

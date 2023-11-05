extends Node2D

var shoot_wolfs = []


func kill_the_wolf(collider):
	if collider != null and collider.is_in_group("wolf"):
		print("killed a wolf")
		shoot_wolfs.append(collider)
		var distance = global_position.distance_to(collider.global_position)
		$WolfKillerTimer.wait_time = distance / 250
		$WolfKillerTimer.start()


func _physics_process(delta: float):
	if !GameState.has_shotgun:
		return
	get_parent().get_node("Sprite2D/Shotgun").visible = true

	if $ShotsFIred/ShotgunGPUParticles2D.emitting:
		return

	var target_point = global_position + get_parent().velocity
	$ShotsFIred.look_at(target_point)
	if Input.is_action_just_pressed("shoot"):
		if GameState.ammo <= 0:
			return

		GameState.ammo -= 1
		$ShotsFIred/ShotgunGPUParticles2D.emitting = true
		$ShotsFIred/ShotgunRayCast

		if $ShotsFIred/ShotgunRayCast.is_colliding():
			var collider = $ShotsFIred/ShotgunRayCast.get_collider()
			kill_the_wolf(collider)

		if $ShotsFIred/ShotgunRayCast2.is_colliding():
			var collider = $ShotsFIred/ShotgunRayCast2.get_collider()
			kill_the_wolf(collider)

		if $ShotsFIred/ShotgunRayCast3.is_colliding():
			var collider = $ShotsFIred/ShotgunRayCast3.get_collider()
			kill_the_wolf(collider)

		if $ShotsFIred/ShotgunRayCast4.is_colliding():
			var collider = $ShotsFIred/ShotgunRayCast4.get_collider()
			kill_the_wolf(collider)

		if $ShotsFIred/ShotgunRayCast5.is_colliding():
			var collider = $ShotsFIred/ShotgunRayCast5.get_collider()
			kill_the_wolf(collider)

func _on_wolf_killer_timer_timeout():
	for w in shoot_wolfs:
		w.queue_free()
	shoot_wolfs = []

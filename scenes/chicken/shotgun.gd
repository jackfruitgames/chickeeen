extends Node2D

var shoot_wolfs = []

var RAYS := [
	$ShotsFIred/ShotgunRayCast,
	$ShotsFIred/ShotgunRayCast2,
	$ShotsFIred/ShotgunRayCast3,
	$ShotsFIred/ShotgunRayCast4,
	$ShotsFIred/ShotgunRayCast5,
]


func _physics_process(delta: float):
	var target_point = global_position + get_parent().velocity
	$ShotsFIred.look_at(target_point)
	if Input.is_action_just_pressed("shoot"):
		$ShotsFIred/ShotgunGPUParticles2D.emitting = true

		for ray in RAYS:
			if ray.is_colliding():
				var collider = ray.get_collider()
				if collider != null and collider.is_in_group("wolf"):
					print("killed a wolf")
					shoot_wolfs.append(collider)
					$WolfKillerTimer.start()

func _on_wolf_killer_timer_timeout():
	for w in shoot_wolfs:
		w.queue_free()
	shoot_wolfs = []

extends Enemy

func shoot() -> void:
	if is_firing or $FSM.current_state.current_state is EnemyHidden:
		return

	$FSM.current_state.enter_child("enemyaimmid")

	var bullet = BULLET.instantiate()
	bullet.speed = BULLET_SPEED
	bullet.collision_layer = 9

	var direction_to_player = (player.global_position - global_position).normalized()

	# flip
	var facing_right = direction_to_player.x >= 0
	animated_sprite.flip_h = !facing_right

	var muzzle = $AimMid

	muzzle.position.x = abs(muzzle.position.x) * (1 if facing_right else -1)
	bullet.global_position = muzzle.global_position

	bullet.global_rotation = direction_to_player.angle()

	# Add it to the main scene (instead of the player, so it doesn't move with the player)
	get_parent().add_child(bullet)
	
	current_bullets.append(bullet)
	bullet.tree_exiting.connect(func(): current_bullets.erase(bullet))

	is_firing = true
	weapon_cooldown.start(1.9)


func _on_weapon_cooldown_timeout() -> void:
	is_firing = false
	$FSM.current_state.enter_child("enemyhidden")

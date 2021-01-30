extends Actor

export var _stomp_impulse: = 1000.0

#rebond sur un ennemie
func _on_EnemyDetector_area_entered(area):
	_velocity = calculate_stomp_velocity()

#kill
func _on_EnemyDetector_body_entered(body):
	die()

func _physics_process(delta):
	_velocity = move_and_slide(calculate_move_velocity(), FLOOR_UP)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity():
	var direction: = get_direction()
	var out: = _velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if Input.is_action_just_released("jump") and _velocity.y < 0.0:
		out.y = 0.0
	return out

func calculate_stomp_velocity():
	var out: = _velocity
	out.y = -_stomp_impulse
	return out

func die() -> void:
	PlayData.deaths += 1
	queue_free()

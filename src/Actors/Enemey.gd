extends "res://src/Actors/Actor.gd"

export var score: = 100

func _ready():
	#out of screen
	set_physics_process(false)
	#on screen
	_velocity.x = -speed.x

#kill
func _on_StompDetector_body_entered(body: PhysicsBody2D):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	die()

func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_UP).y

func die():
	queue_free()
	PlayData.score += score	

extends KinematicBody2D

var active = false
var player
var velocity : Vector2
const GRAVITY = 500.0
const JUMP : float = 220.0
const UP : Vector2 = Vector2(0, -1)
const MOVEMENT = 100.0

func _physics_process(delta):
	if active:
		velocity.y += GRAVITY * delta
		
		if $Timer.is_stopped():
			velocity.y = -JUMP
			if player.position.x > global_position.x:
				velocity.x = MOVEMENT
			else:
				velocity.x = -MOVEMENT
			$Timer.start()
		
		if velocity.x > 0:
			velocity.x -= 100 * delta
		
		if velocity.x < 0:
			velocity.x += 100 * delta
			
		if velocity.x > -10 && velocity.x < 10:
			velocity.x = 0

		velocity = move_and_slide(velocity, UP)

func _on_SlimeArea_body_entered(body):
	if body.name == "Player":
		active = true
		player = body

func _on_SlimeArea_body_exited(body):
	if body.name == "Player":
		active = false
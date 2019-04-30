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
		
		if $Area2D/Timer.is_stopped():
			remove_collision_exception_with(player)
		
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
		$Timer.start()
		active = true
		player = body

func _on_SlimeArea_body_exited(body):
	if body.name == "Player":
		active = false

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.knockback(3)
		add_collision_exception_with(body)
		$Area2D/Timer.start()

func _on_HurtBox_body_entered(body):
	if $Area2D/Timer.is_stopped():
		if body.name == "Player":
			body.money += 2
			body.money_changed()
			body.velocity.y = -JUMP
			queue_free()


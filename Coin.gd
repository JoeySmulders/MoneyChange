extends KinematicBody2D

const GRAVITY = 350.0
const SPEED = 50.0
const UP : Vector2 = Vector2(0, -1)

var direction : int = 1
var velocity : Vector2 = Vector2()
var fly = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):

	if !fly:
		velocity.y += GRAVITY * delta
	else:
		$AnimatedSprite.play("Wings")
		if $Timer.is_stopped():
			$AnimatedSprite.play("default")
			velocity.y += GRAVITY * delta

	velocity.x = SPEED * direction
	
	velocity = move_and_slide(velocity)
	
	if velocity.x == 0:
		direction *= -1
		
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

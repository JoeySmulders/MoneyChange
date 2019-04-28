extends KinematicBody2D

const GRAVITY = 350.0
const SPEED = 50.0
const UP : Vector2 = Vector2(0, -1)

var direction : int = 1
var velocity : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):

	velocity.y += GRAVITY * delta
	velocity.x = SPEED * direction
	
	velocity = move_and_slide(velocity)
	
	if velocity.x == 0:
		direction *= -1

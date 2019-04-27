extends KinematicBody2D

const GRAVITY : float = 500.0
const WALKSPEED : float = 100.0
const JUMP : float = 200.0
const UP : Vector2 = Vector2(0, -1)

var health : int
var velocity : Vector2 = Vector2()

func _ready():
	health = 10

func _physics_process(delta : float) -> void:
	
	print(health)
	
	if health < 1:
		die()
	
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = -JUMP
		else:
			velocity.y = 0

	if Input.is_action_pressed("ui_right"):
		velocity.x = WALKSPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -WALKSPEED
	else:
		velocity.x = 0
		
	velocity = move_and_slide(velocity, UP)
	
	if Input.is_action_just_pressed("ui_fire"):
		toss_coin()

func die() -> void:
	print("u ded")
	
func toss_coin() -> void:
	health -= 1
	
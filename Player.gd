extends KinematicBody2D

const GRAVITY : float = 500.0
const WALKSPEED : float = 100.0
const JUMP : float = 200.0
const UP : Vector2 = Vector2(0, -1)

var money : int
var velocity : Vector2 = Vector2()

signal money_change

var Coin = preload("res://Coin.tscn")

func _ready():
	money = 10

func _physics_process(delta : float) -> void:
	
	if money < 1:
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
	
	if Input.is_action_just_pressed("ui_fire") && money > 0:
		toss_coin()
		
	if Input.is_action_just_pressed("ui_down"):
		get_coin()

func die() -> void:
	print("u ded")
	
func toss_coin() -> void:
	money -= 1
	emit_signal("money_change", money)
	
	var coin = Coin.instance()
	coin.position = position
	get_parent().add_child(coin)
	
func get_coin() -> void:
	pass
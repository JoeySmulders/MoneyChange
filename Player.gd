extends KinematicBody2D

const GRAVITY : float = 500.0
const WALKSPEED : float = 100.0
const JUMP : float = 220.0
const UP : Vector2 = Vector2(0, -1)

var money : int
var velocity : Vector2 = Vector2()
var direction : int = 1

onready var coinTimer : Timer = $CoinTimer

signal money_change

var Coin = preload("res://Coin.tscn")

func _ready():
	money = 10

func _physics_process(delta : float) -> void:
	
	velocity.y += GRAVITY * delta
	var snap = Vector2(0,20.0)
	
	if money < 1:
		die()

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			snap = Vector2(0,0.0)
			velocity.y = -JUMP

	if Input.is_action_pressed("ui_right"):
		velocity.x = WALKSPEED
		direction = 1
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -WALKSPEED
		direction = -1
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0

	var floor_velocity = get_floor_velocity() * delta
	velocity = move_and_slide_with_snap(velocity + floor_velocity, snap, UP)

	if Input.is_action_just_pressed("ui_fire") && coinTimer.is_stopped() && money > 0:
		toss_coin()
		coinTimer.start()

	if Input.is_action_just_pressed("ui_down"):
		get_coin()

func die() -> void:
	print("u ded")

func money_changed() -> void:
	emit_signal("money_change", money)

func toss_coin() -> void:
	money -= 1
	money_changed()
	
	var coin = Coin.instance()
	coin.position = position
	coin.direction = direction
	get_parent().add_child(coin)
	
func get_coin() -> void:
	pass
	
func knockback() -> void:
	
	pass

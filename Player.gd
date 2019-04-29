extends KinematicBody2D

const GRAVITY : float = 500.0
const WALKSPEED : float = 100.0
const JUMP : float = 220.0
const UP : Vector2 = Vector2(0, -1)

var money : int
var velocity : Vector2 = Vector2()
var direction : int = 1

var item
var shop : bool = false
var hatItem : bool = false
var coinItem : bool = false
var shoeItem : bool = false
var doubleJumped : bool = false

onready var coinTimer : Timer = $CoinTimer

signal money_change

var Coin = preload("res://Coin.tscn")

func _ready():
	money = 10

func _physics_process(delta : float) -> void:
	
	velocity.y += GRAVITY * delta
	
	if hatItem:
		if shoeItem:
			$AnimatedSprite.play("HatShoe")
		else:
			$AnimatedSprite.play("Hat")
	elif shoeItem:
		$AnimatedSprite.play("Shoe")
	
	if money < 1:
		die()

	if is_on_floor():
		doubleJumped = false
		if Input.is_action_pressed("ui_up"):
			velocity.y = -JUMP
	elif shoeItem && !doubleJumped:
		if Input.is_action_just_pressed("ui_up"):
			doubleJumped = true
			velocity.y = -JUMP * 0.75

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
	velocity = move_and_slide(velocity + floor_velocity, UP)

	if Input.is_action_just_pressed("ui_fire") && coinTimer.is_stopped() && money > 0:
		toss_coin()
		coinTimer.start()
		
	if Input.is_action_just_pressed("ui_down") && shop:
		buy_item(item)
	
func die() -> void:
	get_tree().reload_current_scene()

func money_changed() -> void:
	emit_signal("money_change", money)

func toss_coin() -> void:
	money -= 1
	money_changed()
	
	var coin = Coin.instance()
	coin.position = position
	coin.direction = direction
	get_parent().add_child(coin)
	
func buy_item(itemName) -> void:
	if itemName == "Hat" && money > 5: 
		money -= 5
		hatItem = true
		get_node("../Shop/HatCool").queue_free()
	if itemName == "Coin" && money > 10: 
		money -= 10
		coinItem = true
		get_node("../Shop/CoinWings").queue_free()
	if itemName == "Shoe" && money > 15: 
		money -= 15
		shoeItem = true
		get_node("../Shop/Shoe").queue_free()
	money_changed()
	
func knockback(damage) -> void:
	if $CoinTimer.is_stopped():
		doubleJumped = false
		$CoinTimer.start()
		money -= damage
		money_changed()
		$AnimatedSprite/AnimationPlayer.play("HitAnimation")

#		Boost the player based on the direction of the enemy
		var knockback = Vector2(0,200)
#		Reset gravity and movement
		velocity.x = 0
		velocity.y = 0
#		if position > enemyPosition:
#			velocity.x += knockback.x * 2
#		else:
#			velocity.x -= knockback.x * 2
		velocity.y -= knockback.y * 1.5

func _on_HatCool_body_entered(body):
	shop = true
	item = "Hat"

func _on_CoinWings_body_entered(body):
	shop = true
	item = "Coin"
	
func _on_Shoe_body_entered(body):
	shop = true
	item = "Shoe"
	
func _on_Shoe_body_exited(body):
	shop = false

func _on_CoinWings_body_exited(body):
	shop = false

func _on_HatCool_body_exited(body):
	shop = false

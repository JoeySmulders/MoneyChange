extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextEdit3.text = "You made" + str(money.money) + " money"
	if money.money < 25:
		$TextEdit2.text = "Good job, but you could have made more money!"
	else:
		$TextEdit2.text = "You are rich! Great job!"



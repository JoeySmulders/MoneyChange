extends Area2D

export var value = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	$AnimatedSprite/AnimationPlayer.play("exist")

func _on_MoneyPickup_body_entered(body):
	if body.get_name() == "Player":
		body.money += value
		body.money_changed()
		queue_free()

extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if activated:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true

func _on_Area2D_body_entered(body):
	if !activated:
		if "Coin" in body.name:
			activated = true
			$AnimatedSprite.play("Active")
			get_parent().get_node("Area2D/AnimatedSprite").play("Active")
			body.queue_free()
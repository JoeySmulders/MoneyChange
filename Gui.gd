extends MarginContainer

onready var label = $TextEdit/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var current_player_money = $"../../Player".money
	label.text = str(current_player_money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_money_change(money):
	label.text = str(money)


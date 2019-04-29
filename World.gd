extends Node2D

onready var window_size = get_viewport_rect().size
onready var player = $Player
onready var player_world_pos = get_player_grid_pos()

func _physics_process(delta):
	update_camera(get_player_grid_pos())

func get_player_grid_pos():
	var pos = player.position
	var x = floor(pos.x / window_size.x)
	var y = floor(pos.y / window_size.y)
	return Vector2(x, y)
	
func update_camera(new_player_grid_pos):
	var transform = Transform2D()
	
	if new_player_grid_pos != player_world_pos:
		player_world_pos = new_player_grid_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = -player_world_pos * window_size
		get_viewport().set_canvas_transform(transform)
		
	return transform
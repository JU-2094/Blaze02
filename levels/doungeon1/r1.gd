extends Node2D

onready var screen_size = OS.get_real_window_size()
onready var player = get_node("Player")
onready var player_w_pos = get_player_grid_pos()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#Player position warps:
	if worlddata.psname=="doungeonp1-1":
		$Player.position=Vector2(978.099731,511.869263)
	if worlddata.psname=="doungeonp1-2":
		$Player.position=Vector2(38.047424,508.746826)
	if worlddata.psname=="doungeon2d1u":
		$Player.position=Vector2(513.181885,982.653564)
	if worlddata.psname=="doungeon2d1d":
		$Player.position=Vector2(514.178284,47.580017)
	
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = -player.position + screen_size / 2
	get_viewport().set_canvas_transform(canvas_transform)
	
	pass

func _process(delta):
	#var canvas_transform = get_viewport().get_canvas_transform()
	#canvas_transform[2] = -( get_node("Player").position + screen_size) / 2
	#get_viewport().set_canvas_transform(canvas_transform)
	pass

func get_player_grid_pos():
	var pos = player.position
	var x = (pos.x / screen_size.x)
	var y = (pos.y / screen_size.y)
	return Vector2(x,y)
	pass
	

func _on_Player_move():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = -player.position + screen_size / 2
	get_viewport().set_canvas_transform(canvas_transform)
	var new_player_grid_pos = get_player_grid_pos()
	var transform = Transform2D()
	
	if new_player_grid_pos != player_w_pos:
		player_w_pos = new_player_grid_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = -player_w_pos * screen_size
		get_viewport().set_canvas_transform(transform)
	return transform
	pass # replace with function body














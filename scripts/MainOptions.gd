extends MarginContainer

signal new_game

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_NewGame_pressed():
	var file = File.new()
	# rewrite previous data
	file.open("res://data/game.dat", file.WRITE)
	get_tree().change_scene("res://levels/testlevel.tscn")

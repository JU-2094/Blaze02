extends MarginContainer

signal new_game

func _ready():
	pass

#func _process(delta):
#	pass

func _on_NewGame_pressed():
	var file = File.new()
	# rewrite previous data
	file.open("res://data/game.dat", file.WRITE)
	get_tree().change_scene("res://levels/doungeon2d.tscn")


func _on_Options_pressed():
	
	pass # replace with function body

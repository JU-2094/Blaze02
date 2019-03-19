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
	worlddata.goto_scene("res://levels/doungeon1/r1.tscn")
	#get_tree().change_scene("res://levels/doungeon1/r1.tscn")


func _on_Options_pressed():
	worlddata.goto_scene("res://Menus/OptionMenu.tscn")
	pass # replace with function body


func _on_Continue_pressed():
	pass # replace with function body

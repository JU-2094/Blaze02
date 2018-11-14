extends Node

var game_data
var file_data

func _ready():
	file_data = File.new()
	file_data.open("res://data/game.dat", file_data.READ_WRITE)
	pass

#func _process(delta):


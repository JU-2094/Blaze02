extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _on_Area2D_body_entered(body):
	var file = File.new()
	# rewrite previous data
	file.open("res://data/game.dat", file.WRITE)
	get_tree().change_scene("res://levels/testlevel.tscn")
	pass # replace with function body

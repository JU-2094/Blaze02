extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var BULLET = load('res://objects/BulletTorret1.tscn')
var bulletL
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$AudioStreamPlayer.play()
	# get_parent().add_child(bulletL)
	pass
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

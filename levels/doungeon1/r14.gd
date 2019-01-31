extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if worlddata.psname=="doungeon2d":
		$Player.position=Vector2(46.98938,279.035645)
	if worlddata.psname=="doungeon2d1l":
		$Player.position=Vector2(1494.66748,279.035645)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

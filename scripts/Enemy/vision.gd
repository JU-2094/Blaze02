extends Area2D
var intrud=Vector2()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal intruder(intrud)
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#Enemy location:	
	print("aqui",get_node("../").get_transform().origin)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#Function that detects intruders, is the intruder is player then emits signal intruder to raycast
func _on_Vision_body_entered(body):
	#print("pepapig"+body.get_name())
	var name= body.get_name()
	intrud = body.get_transform().origin
	if  name =="Player" :
		emit_signal("intruder",body)
		print("see you:",body.name)
	else :
		print("see you:",body.name)
	pass # replace with function body

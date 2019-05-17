extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var c= false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):

#	if Input.is_key_pressed(KEY_P) && worlddata.pause_state==true:
##		worlddata.pause_state==false
#		$pause_pop_up.hide()
#		get_tree().paused = false
	pass	

func _input(event):
	if  event.is_action_pressed("ui_pause") :
		get_tree().paused = not get_tree().paused 
		print("true")
		if get_tree().paused:
			$pause_pop_up.show()
		else:
			$pause_pop_up.hide()
	pass

func _on_Exit_pressed():
	get_tree().quit()
	pass # replace with function body


func _on_Return_pressed():
	print("entra button")
	if get_tree().paused and c:
		c=false
		$pause_pop_up.hide()
		get_tree().paused = false
	else:
		c=true
	pass # replace with function body

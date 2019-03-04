extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		print('pause event')
		var state = not get_tree().paused
		get_tree().paused = not get_tree().paused
		visible = state
	pass


func _on_Button_pressed():
	print('test for signals with pause')
	worlddata.goto_scene('res://levels/MainMenu.tscn')
	pass # replace with function body

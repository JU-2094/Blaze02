extends MarginContainer

func _on_OKButton_pressed():
	worlddata.music_vol = $VBoxContainer/VolSlider.value
	worlddata.goto_scene("res://levels/MainMenu.tscn")
	pass # replace with function body


func _on_ResetButton_pressed():
	worlddata.music_vol = 100
	pass # replace with function body

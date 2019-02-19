extends AudioStreamPlayer2D

var stream_handler

func setup():
	print('AudioStream initialized')
	stream_handler = AudioStreamPlayer.new()
	stream_handler.connect("finished", self, "_on_finished_track")
	pass

func instant_play(scene_name, dict_data):
	if scene_name in dict_data:
		var data_path = dict_data[scene_name]
		var sfx = load(data_path)
		
		print(data_path)
		sfx.set_loop(false)
		stream_handler.set_stream(sfx)
		stream_handler.play()
	pass

func _on_finished_track():
	print("song ended")
	pass

## Todo delayed play, use a Queue 

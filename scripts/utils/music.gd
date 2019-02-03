extends Node

var stream_handler
var audiostream

func setup():
	pass
	#stream_handler = AudioStreamPlayer()
	#stream_handler.connect("finished", self, "_on_finished_track")

func instant_play(scene_name, dict_data):
	if scene_name in dict_data:
		var data_path = dict_data[scene_name]
		print(data_path)
#	audiostream = AudioStream(dict_data[scene_name])
#	stream_handler.set_stream(audiostream)
#	stream_handler.play()
	
	pass

func _on_finished_track():
	print("song ended")
	pass

## Todo delayed play, use a Queue 

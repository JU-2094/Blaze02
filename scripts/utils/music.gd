extends AudioStreamPlayer2D

var stream_handler
var isattach
var current_path

func setup():
	print('AudioStream initialized')
	stream_handler = AudioStreamPlayer.new()
	stream_handler.connect("finished", self, "_on_finished_track")
	isattach = false
	current_path = ""
	pass

func instant_play(scene_name, dict_data):
	var data_path = ""
	if scene_name in dict_data:
		data_path = dict_data[scene_name]
		
		if (current_path == data_path) and stream_handler.playing:
			return 
		var sfx = load(data_path)
		sfx.set_loop(false)
		
		print('music volume', worlddata.music_vol)
		stream_handler.set_volume_db(worlddata.music_vol)
		stream_handler.set_pitch_scale(0.2)
		stream_handler.set_stream(sfx)
		stream_handler.play()
	else:
		print('audio not found for current scene::', scene_name)
	current_path = data_path
	pass

	
func stop_play(force=false, scene_name=null, dict_data=null):
	if force:
		stream_handler.stop()
		return
	
	if scene_name in dict_data:
		var data_path = dict_data[scene_name]
		if current_path == data_path:
			return
	stream_handler.stop()

func _on_finished_track():
	print("song ended")
	pass

## Todo delayed play, use a Queue 

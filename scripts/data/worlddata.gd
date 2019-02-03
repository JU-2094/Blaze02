extends Node
var current_scene = null
var prev_scene = null
var csname
var psname
var music_obj
# Dictionary for controlling the music
#var music_dic = {'r1.tscn':'res://assets/music/theme.ogg'}

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	#var anim_res = load('res://scripts/utils/music.gd')
	#music_obj = anim_res.new()
	#music_obj.setup()
	#print(current_scene.get_name())

func goto_scene(path):
	#music_obj.instant_play(path.get_file(), music_dic)
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
    psname = current_scene.get_name() #save prevscene name
    # It is now safe to remove the current scene
    current_scene.free()

    # Load the new scene.
    var s = ResourceLoader.load(path)

    # Instance the new scene.
    current_scene = s.instance()
    csname=current_scene.get_name()  
    # Add it to the active scene, as child of root.
    get_tree().get_root().add_child(current_scene)

    # Optionally, to make it compatible with the SceneTree.change_scene() API.
    get_tree().set_current_scene(current_scene)

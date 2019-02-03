extends Node
var current_scene = null
var prev_scene = null
var csname
var psname
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	#print(current_scene.get_name())

func goto_scene(path):
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

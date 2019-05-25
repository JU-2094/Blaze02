extends Node2D
export var sx=600
var sy = 0
export onready var objeto
#export onready var entity


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var OBJECT = preload('res://objects/BulletTorret1.tscn')
#export var ENTITY = preload('res://entities/Player.tscn')
var rn
var target
var entity
# Called when the node enters the scene tree for the first time.
func _ready():
	entity = find_node_by_name(get_tree().get_root(), "Player")
	if entity:
		$Timer.start()
		$Position2D.global_position=Vector2(sx,sy)
		rn = RandomNumberGenerator.new()
		print("a wiwi")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Timer.start()
	pass


func _on_Timer_timeout():
	rn.randomize()
	sy=rn.randi_range(1, 600)
	var object = OBJECT.instance()
	add_child(object)
	$Position2D.global_position=Vector2(sx,sy)
	object.global_position = $Position2D.global_position
	if object.otype=="bullet":
		var objective = (entity.global_position - object.global_position).normalized()
		object.setup(objective)
	#print(object.global_position)
	pass # Replace with function body.

func find_node_by_name(root, name):
	if(root.get_name() == name): return root
	for child in root.get_children():
		if(child.get_name() == name):
			return child
		var found = find_node_by_name(child, name)
		if(found): return found
	return null
	pass
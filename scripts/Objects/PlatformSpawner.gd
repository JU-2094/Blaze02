extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var a
var plat
var psize = Vector2(1,1)
export var btype ="normal"
var width = ProjectSettings.get_setting("Display"
# Called when the node enters the scene tree for the first time.
func _ready():
	print("hola")
	var ptype ="normal"
	var psize = Vector2(1,1)
	plat = load('res://objects/BOX.tscn').instance()
	#var temp="ice"
	plat.init_para(btype)#.init_fr(ptype,psize)
	add_child(plat)
	print(plat)
	#print(plat.name)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(plat.transform)
	pass
func init_para():
	
	pass
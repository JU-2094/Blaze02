extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var btype="normal"
# Called when the node enters the scene tree for the first time.
func _ready():
	Box_type()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init_para(a):
	btype=a
	Box_type()
	pass

func Box_type():
	if btype == "normal":
		$Sprite.texture=load("res://assets/tmp_player.png")
	if btype == "sticky":
		$Sprite.texture=load("res://assets/tile.png")
	if btype == "ice":
		$Sprite.texture=load("res://assets/tmp_enemy.png")
	pass
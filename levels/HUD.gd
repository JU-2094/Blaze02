extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var bombs 
var health
var coins 
var lives
var hbar

func _ready():
	# Called when the node is added to the scene for the first time.
	## Initialization here
	bombs=$MarginContainer/HBoxContainer/Counter3/Background/Number
	coins=$MarginContainer/HBoxContainer/Counter2/Background/Number
	lives=$MarginContainer/HBoxContainer/Counter/Background/Number
	hbar=$MarginContainer/HBoxContainer/Bars/Bar/Gauge
	lives.text =  str(playerdata.stats["lives"])
	health= $MarginContainer/HBoxContainer/Bars/Bar/Count/Background/Number
	# res://assets/HUD/rupees_icon.png
	#print(bombs.text)
func _process(delta):
	bombs.text =  str(playerdata.items["bombs"])
	coins.text =  str(playerdata.items["coins"])
	health.text = str(playerdata.stats["health"])
	lives.text =  str(playerdata.stats["lives"])
	hbar.value =playerdata.stats["health"]
	pass

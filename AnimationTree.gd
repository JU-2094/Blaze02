extends AnimationTree

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playback
# Called when the node enters the scene tree for the first time.
func _ready():
	playback = get("parameters/playback")
	playback.start("walkr")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var LEFT = Input.is_action_just_pressed("ui_left")
	var RIGHT = Input.is_action_just_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RLEFT = Input.is_action_just_released("ui_left")
	var RRIGHT = Input.is_action_just_released("ui_right")
	if LEFT:
		playback.travel("walkl")
	if RIGHT:
		playback.travel("hitr")
	if RLEFT:
		playback.travel("hitr")
	if RRIGHT:
		playback.travel("walkr")


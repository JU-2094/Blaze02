extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed  = 60
export var gravity = 10
export var jump = -250
const flor = Vector2(0,-1)
var ground =false
var velocity = Vector2()
var up
var down
var left
var right
var playback
# Called when the node enters the scene tree for the first time.
func _ready():
	playback = get_node("AnimationPlayer/AnimationTree").get("parameters/playback")
	playback.start("idler")
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		velocity.x = speed
		playback.travel("runr")
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		velocity.x = -speed
		playback.travel("runr")
	elif Input.is_action_just_released("ui_left"):
		$Sprite.flip_h = true
		playback.travel("idler")
	elif Input.is_action_just_released("ui_right"):
		playback.travel("idler")
	else:
		#playback.travel("idler")
		velocity.x=0
	if Input.is_action_pressed("ui_up"):
		playback.travel("jumpr")
		if ground:
			velocity.y = jump
	elif Input.is_action_just_released("ui_up"):
		playback.travel("idler")
	velocity.y += gravity
	if is_on_floor():
		ground=true
	else:
		ground=false
	velocity = move_and_slide(velocity,flor)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

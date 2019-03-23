extends KinematicBody2D

export (int) var speed
var movedir = Vector2(0,0)
const GRAVITY = 196.0
const WALK_SPEED = 200.0
const JUMP = 200.0
func _ready():
	#print(worlddata.csname)
	
	pass
	

func _physics_process(delta): 
	controls_npc_ort()
	movement_npc()
	pass

func controls_npc_ort():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	#if LEFT:
		#$Sprite/AnimationPlayer.play("walkl")
	#if RIGHT:
		#$Sprite/AnimationPlayer.play("walkr")
	#if UP:
		#$Sprite/AnimationPlayer.play("up")
	#if DOWN:
		#$Sprite/AnimationPlayer.play("down")
	pass

func controls_npc_plt():
	movedir.y =GRAVITY
	if Input.is_action_pressed("ui_left"):
		movedir.x = -WALK_SPEED
		if Input.is_key_pressed(KEY_SPACE) && movedir.y >= 0 :
			movedir.y =-JUMP
	elif Input.is_action_pressed("ui_right"):
		movedir.x =  WALK_SPEED
		if Input.is_key_pressed(KEY_SPACE) && movedir.y >= 0 :
			movedir.y =-JUMP
	elif Input.is_key_pressed(KEY_SPACE) && movedir.y >= 0 :
		movedir.y =-JUMP
	else:
		movedir.x = 0#PARECE SER QUE NO HAY TANTA DIFERENCIA ENTRE PROCESS Y PHYSICS PROCESS
	
	pass

func movement_npc():
	var motion = movedir.normalized() * speed
	move_and_slide(motion, Vector2(0,0))
	pass
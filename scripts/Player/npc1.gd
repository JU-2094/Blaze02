extends KinematicBody2D

export (int) var speed
var movedir = Vector2(0,0)
func _ready():
	
	pass
	

func _physics_process(delta): #PARECE SER QUE NO HAY TANTA DIFERENCIA ENTRE PROCESS Y PHYSICS PROCESS
	controls_npc()
	movement_npc()
	pass

func controls_npc():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	if LEFT:
		$Sprite/AnimationPlayer.play("left")
	if RIGHT:
		$Sprite/AnimationPlayer.play("right")
	if UP:
		$Sprite/AnimationPlayer.play("up")
	if DOWN:
		$Sprite/AnimationPlayer.play("down")
	pass
func movement_npc():
	var motion = movedir.normalized() * speed
	move_and_slide(motion, Vector2(0,0))
	pass
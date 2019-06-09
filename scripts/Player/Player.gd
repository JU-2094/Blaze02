extends KinematicBody2D

signal hit

var speed=100
var anim_obj 
var anim_handler
var anim_item_handler
var screensize
var isoverlay = false 
var state_item
var orientation
var screen_size = OS.get_real_window_size()
var lock
var lock_weapon

func get_input():
	var dir = \
	{
	"right" : (Input.is_action_pressed('ui_right') ), 
	"left" : (Input.is_action_pressed('ui_left') ), 
	"up" : (Input.is_action_pressed('ui_up') ), 
	"down" : (Input.is_action_pressed('ui_down') ),
	"right_rls" : (Input.is_action_just_released("ui_right")) ,
	"left_rls" : (Input.is_action_just_released("ui_left")),
	"up_rls" : (Input.is_action_just_released("ui_up") ),
	"down_rls" : (Input.is_action_just_released("ui_down") )
	}
	return dir

func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	screensize = get_viewport_rect().size
	state_item = 0
	orientation = 4
	# Todo get struct of current items.. design it later
	# For know will be the number of bombs available
	lock = 0
	var anim_res = load('res://scripts/utils/animation.gd')
	anim_obj = anim_res.new()
	anim_handler = get_node("Sprite/AnimationPlayer/AnimationTree").get("parameters/playback")
	anim_item_handler = get_node("Bomb/AnimationPlayer/AnimationTree").get("parameters/playback")
	
	anim_handler.start("idle_down")
	lock_weapon = 0
	# this avoid the user to be visible when the game starts
	#hide()  

func _process(delta):
	check_health()
	check_powerups()
	var state_input = get_input()
	var velocity = Vector2()
	var state = 0
		
	if state_input["right"]:
		velocity.x += 1
		state += 1
		orientation = 1
		
		if state_item:
			anim_handler.travel("carry_right")
		else:
			anim_handler.travel("right")
	if state_input["right_rls"]:
		if state_item:
			anim_handler.travel("idle_carry_right")
		else:
			anim_handler.travel("idle_right")
		
	if state_input["left"]:
		velocity.x -= 1
		state += 2
		orientation = 2
		if state_item:
			anim_handler.travel("carry_left")
		else:
			anim_handler.travel("left")
	if state_input["left_rls"]:
		if state_item:
			anim_handler.travel("idle_carry_left")
		else:
			anim_handler.travel("idle_left")
		
	if state_input["up"]:
		velocity.y -= 1
		state += 4
		orientation = 3
		if state_item:
			anim_handler.travel("carry_up")
		else:
			anim_handler.travel("up")
	if state_input["up_rls"]:
		if state_item:
			anim_handler.travel("idle_carry_up")
		else:
			anim_handler.travel("idle_up")
		
	if state_input["down"]:
		velocity.y += 1
		state += 8
		orientation = 4
		if state_item:
			anim_handler.travel("carry_down")
		else:
			anim_handler.travel("down")
	if state_input["down_rls"]:
		if state_item:
			anim_handler.travel("idle_carry_down")
		else:
			anim_handler.travel("idle_down")
	
	if Input.is_key_pressed(KEY_1):
		if state_item == 0:
			var node_item = get_node(playerdata.cur_item_res[playerdata.cur_item])
			node_item.visible = true
			#$AudioStreamPlayer.play()
			state_item = 1
			anim_item_handler.start("bomb_up")
			match orientation:
				1:
					anim_handler.travel("grab_right")
				2:
					anim_handler.travel("grab_left")
				3:
					anim_handler.travel("grab_up")
				4:
					anim_handler.travel("grab_down")
				_:
					anim_handler.travel("grab_down")
			
			
	
	if Input.is_key_pressed(KEY_SPACE):
		if state_item:
			match orientation:
				1:
					anim_item_handler.travel("throw_bomb_right")
				2:
					anim_item_handler.travel("throw_bomb_left")
				3:
					anim_item_handler.travel("throw_bomb_up")
				4:
					anim_item_handler.travel("throw_bomb_down")
				_:
					pass
			
		else:
			match orientation:
				1:
					anim_handler.travel("sword_right")
				2:
					anim_handler.travel("sword_left")
				3:
					anim_handler.travel("sword_up")
				4:
					anim_handler.travel("sword_down")
				_:
					pass
	if Input.is_key_pressed(KEY_B):
		print(worlddata.prev_scene.get_name())
		print(worlddata.current_scene.get_name())
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	# Shortcut $AnimatedSprite --> get_node("AnimatedSprite")
	#if state_item == 0 or state_item == 2:
	#	move_and_slide(velocity, Vector2(0,0))
	move_and_slide(velocity, Vector2(0,0))

# signal callback
func _on_Player_body_entered(body):
	#hide()
	print("DUH ")
	emit_signal("hit")
	"""
	By turning it off, we make sure we don’t trigger 
	the hit signal more than once.
	If there is a healt bar it should be allowed to receive multiple hits
	"""
	#$CollisionShape2D.disabled = true
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_PlayerArea_area_entered(area):
	print("hit")
	if area.get_name() != "Vision":
		isoverlay = true
	#if area.get_name() == "EnemyArea":
	#	emit_signal("hit")


func _on_PlayerArea_area_exited(area):
	isoverlay = false

# TODO this needs refactor
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "grab_down":
		if playerdata.items["bombs"] > 0:
			state_item = 2
		else:
			state_item = 0
	elif lock_weapon:
		lock_weapon = 0

# TODO this need refactor
"""
func _on_AnimationBomb_finished(anim_name):
	print('END OF ANIM')
	if anim_name != "bomb_up":
		print('here')
		$Bomb.visible = false
		$Bomb.position.x = 0
		$Bomb.position.y = 0
		$Bomb/AnimationPlayer.stop()
		$Bomb/AudioStreamPlayer.play()
		playerdata.items["bombs"] -=1
		state_item = 0
"""
func _on_PlayerArea_body_entered(body):
	print("DUH ",body.name)
	if body.name == "Enemy":
		playerdata.stats["health"] -=20
		
	pass # replace with function body

func check_health():
	if playerdata.stats["health"] <= 0 && playerdata.stats["lives"]>0:
		playerdata.stats["lives"]-=1
		playerdata.stats["health"]=playerdata.maxstats["health"]
	if playerdata.stats["health"] <= 0 && playerdata.stats["lives"]==0:
		anim_handler.travel("death")
		print("you're virtually death")
	pass


var timerpu
var is_timerpu = true
func check_powerups():
	if playerdata.powerups["speedup"] and is_timerpu:
		is_timerpu=false
		#print("speedup")
		speed=200
		timerpu = Timer.new()
		timerpu.set_wait_time(4)
		timerpu.connect("timeout",self,"_on_timer_timeout") 
		add_child(timerpu) #to process"
		timerpu.start()
			
func _on_timer_timeout():
	playerdata.powerups["speedup"]=false
	timerpu.stop()
	is_timerpu= true
	speed=100

func _on_Item_animation_finished(anim_name):
	print("HERE!!")
	pass # Replace with function body.

func _on_Item_animation_started(anim_name):
	print("INIT !! HERE!!")
	pass # Replace with function body.

func on_item_anim_end(itype):
	if itype == "explosive":
		anim_item_handler.travel("explode")
	pass

func bomb_explode_callback():
	$Bomb.visible = false
	$Bomb.position.x = 0
	$Bomb.position.y = 0
	playerdata.items["bombs"] -=1
	state_item = 0

	pass

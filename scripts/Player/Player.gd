extends KinematicBody2D

signal hit

export (int) var speed
var anim_obj 
var screensize
var isoverlay = false 
var state_item
var orientation
var screen_size = OS.get_real_window_size()
var lock
var lock_weapon

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
	lock_weapon = 0
	# this avoid the user to be visible when the game starts
	#hide()  

func _process(delta):
	var velocity = Vector2()
	var state = 0
		
	if Input.is_action_pressed('ui_right') or Input.is_key_pressed(KEY_D):
		velocity.x += 1
		state += 1
		orientation = 1
		
	if Input.is_action_pressed('ui_left') or Input.is_key_pressed(KEY_A):
		velocity.x -= 1
		state += 2
		orientation = 2
		
	if Input.is_action_pressed('ui_up') or Input.is_key_pressed(KEY_W):
		velocity.y -= 1
		state += 4
		orientation = 3
		
	if Input.is_action_pressed('ui_down') or Input.is_key_pressed(KEY_S):
		velocity.y += 1
		state += 8
		orientation = 4
	
	if Input.is_key_pressed(KEY_1):
		if state_item == 0:
			$AudioStreamPlayer.play()
			state_item = 1
	
	if Input.is_key_pressed(KEY_SPACE):
		if state_item == 2:
			state_item = 4
		else:
			lock_weapon = 1
			 
	if Input.is_key_pressed(KEY_B):
		print(worlddata.prev_scene.get_name())
		print(worlddata.current_scene.get_name())
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	# Shortcut $AnimatedSprite --> get_node("AnimatedSprite")
	if state_item == 0 or state_item == 2:
		move_and_slide(velocity, Vector2(0,0))
	
	set_anim(state)

# signal callback
func _on_Player_body_entered(body):
	#hide()
	print("DUH ", body.get_name())
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
	if area.get_name() != "Vision":
		isoverlay = true
	#if area.get_name() == "EnemyArea":
	#	emit_signal("hit")


func _on_PlayerArea_area_exited(area):
	isoverlay = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "grab_down":
		if playerdata.items["bombs"] > 0:
			state_item = 2
		else:
			state_item = 0
	elif lock_weapon:
		lock_weapon = 0

func set_anim(state):
	var stop = false
	var node_player = $Sprite/AnimationPlayer
	
	var node_item = get_node(playerdata.cur_item_res[playerdata.cur_item])
	if !state_item:
		if !state:
			stop = true
		
		# 0 - right, 1 - left, 2 - up, 3 - down 
		match state:
			1:
				state = 0
			2:
				state = 1
			4:
				state = 2
			8:
				state = 3
			9:
				state = 3
			10:
				state = 3
			_:
				state = 2
			# Se le suma 9 porque ahi empiezan las animaciones de la espada en playerdata
		
		if lock_weapon:
			anim_obj.play_anim_item(orientation + 8, node_player, playerdata.anim["player"])
		else:
			if !lock_weapon:
				anim_obj.play_anim(state, node_player, playerdata.anim["player"] , stop)
	else:
		match state_item:
			1:
				state = 8
				anim_obj.play_anim_item(state, node_player, playerdata.anim["player"], playerdata.items[playerdata.cur_item], \
										node_item, playerdata.anim[playerdata.cur_item], 0)
			2:
				if !state:
					stop = true
				# carry: 4 - right, 5 - left, 6 - up, 7 - down
				match state:
					1:
						state = 4
					2:
						state = 5
					4:
						state = 6
					8:
						state = 7
					9:
						state = 7
					10:
						state = 7
					_:
						state = 6
				anim_obj.play_anim(state, node_player, playerdata.anim["player"] , stop)
			4:
				if lock == 0:
					node_player.stop()
					anim_obj.play_anim(orientation, node_item.get_node('AnimationPlayer'), playerdata.anim[playerdata.cur_item])


func _on_AnimationBomb_finished(anim_name):
	if anim_name != "bomb_up":
		$Bomb.visible = false
		$Bomb.position.x = 0
		$Bomb.position.y = 0
		$Bomb/AnimationPlayer.stop()
		$Bomb/AudioStreamPlayer.play()
		playerdata.items["bombs"] -=1
		playerdata.items["coins"] +=1
		#items -= 1
		state_item = 0
		lock = 0



func _on_Bomb_animation_started(anim_name):
	if anim_name != "bomb_up":
		lock = 1

extends KinematicBody2D

signal hit

export (int) var speed
var screensize
var isoverlay = false
var items
var state_item
var orientation
var screen_size = OS.get_real_window_size()

func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	screensize = get_viewport_rect().size
	state_item = 0
	orientation = 0
	# Todo get struct of current items.. design it later
	# For know will be the number of bombs available
	items = 10
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
		
	if Input.is_key_pressed(KEY_SPACE):
		if state_item == 0:
			state_item = 1 
		elif state_item == 2:
			state_item = 4
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	# Shortcut $AnimatedSprite --> get_node("AnimatedSprite")
	if state_item != 1:
		move_and_slide(velocity, Vector2(0,0))
	#position += velocity * delta
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y)
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
		if items > 0:
			state_item = 2
		else:
			state_item = 0
	pass

func set_anim(state):
	if !state_item:
		match state:
			0:
				$Sprite/AnimationPlayer.stop()
			1:
				if $Sprite/AnimationPlayer.current_animation != "right":
					$Sprite/AnimationPlayer.play("right")
			2:
				if $Sprite/AnimationPlayer.current_animation != "left":
					$Sprite/AnimationPlayer.play("left")
			4:
				if $Sprite/AnimationPlayer.current_animation != "up":
					$Sprite/AnimationPlayer.play("up")
			8:
				if $Sprite/AnimationPlayer.current_animation != "down":
					$Sprite/AnimationPlayer.play("down")
			9:
				if $Sprite/AnimationPlayer.current_animation != "down":
					$Sprite/AnimationPlayer.play("down")
			10:
				if $Sprite/AnimationPlayer.current_animation != "down":
					$Sprite/AnimationPlayer.play("down")
			_:
				if $Sprite/AnimationPlayer.current_animation != "up":
					$Sprite/AnimationPlayer.play("up")
	else:
		match state_item:
			1:
				if $Sprite/AnimationPlayer.current_animation != "grab_down":
					if items > 0:
						$Bomb.visible = true
						$Bomb/AnimationPlayer.play("bomb_up")
					$Sprite/AnimationPlayer.play("grab_down")
			2:
				match state:
					0:
						$Sprite/AnimationPlayer.stop()
					1:
						if $Sprite/AnimationPlayer.current_animation != "carry_right":
							$Sprite/AnimationPlayer.play("carry_right")
					2:
						if $Sprite/AnimationPlayer.current_animation != "carry_left":
							$Sprite/AnimationPlayer.play("carry_left")
					4:
						if $Sprite/AnimationPlayer.current_animation != "carry_up":
							$Sprite/AnimationPlayer.play("carry_up")
					8:
						if $Sprite/AnimationPlayer.current_animation != "carry_down":
							$Sprite/AnimationPlayer.play("carry_down")
					9:
						if $Sprite/AnimationPlayer.current_animation != "carry_down":
							$Sprite/AnimationPlayer.play("carry_down")
					10:
						if $Sprite/AnimationPlayer.current_animation != "carry_down":
							$Sprite/AnimationPlayer.play("carry_down")
					_:
						if $Sprite/AnimationPlayer.current_animation != "carry_up":
							$Sprite/AnimationPlayer.play("carry_up")
			4:
				match orientation:
					1:
						$Bomb/AnimationPlayer.play("throw_bomb_right")
					2:
						$Bomb/AnimationPlayer.play("throw_bomb_left")
					4:
						$Bomb/AnimationPlayer.play("throw_bomb_up")
					8:
						$Bomb/AnimationPlayer.play("throw_bomb_down")
					_:
						$Bomb/AnimationPlayer.play("throw_bomb_up")
				state_item = 0



func _on_AnimationBomb_finished(anim_name):
	#if anim_name != "up" and state_item != 2:
	#	state_item = 0
	#	$Bomb.visible = false
	pass


extends KinematicBody2D

signal hit

export (int) var speed
var screensize
var isoverlay = false

func _ready():
	screensize = get_viewport_rect().size
	# this avoid the user to be visible when the game starts
	#hide()  

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed('ui_right') or Input.is_key_pressed(KEY_D):
		velocity.x += 1
		$Sprite/AnimationPlayer.play("right")
	if Input.is_action_pressed('ui_left') or Input.is_key_pressed(KEY_A):
		velocity.x -= 1
		$Sprite/AnimationPlayer.play("left")
	if Input.is_action_pressed('ui_up') or Input.is_key_pressed(KEY_W):
		velocity.y -= 1
		$Sprite/AnimationPlayer.play("up")
	if Input.is_action_pressed('ui_down') or Input.is_key_pressed(KEY_S):
		velocity.y += 1
		$Sprite/AnimationPlayer.play("down")
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#$AnimatedSprite.play()
	else:
		 $Sprite/AnimationPlayer.play("down")
	# Shortcut $AnimatedSprite --> get_node("AnimatedSprite")
	move_and_slide(velocity, Vector2(0,0))
	#position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	# Choosing animation
	if velocity.x != 0:
		#$Sprite/AnimationPlayer.play("right")
		#$AnimatedSprite.flip_v = false
		#$AnimatedSprite.flip_h = velocity.x < 0
		pass
	elif velocity.y != 0:
		#$Sprite/AnimationPlayer.play("up")
		#$AnimatedSprite.flip_v = velocity.y > 0
		pass
		

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

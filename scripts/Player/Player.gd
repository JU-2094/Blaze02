extends RigidBody2D

signal hit

export (int) var speed
var screensize

func _ready():
	screensize = get_viewport_rect().size
	# this avoid the user to be visible when the game starts
	#hide()  

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	# Shortcut $AnimatedSprite --> get_node("AnimatedSprite")
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	# Choosing animation
	if velocity.x != 0:
		#$AnimatedSprite.animation = "right"
		#$AnimatedSprite.flip_v = false
		#$AnimatedSprite.flip_h = velocity.x < 0
		pass
	elif velocity.y != 0:
		#$AnimatedSprite.animation = "up"
		#$AnimatedSprite.flip_v = velocity.y > 0
		pass
		

# signal callback
func _on_Player_body_entered(body):
	#hide()
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

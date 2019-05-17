extends StaticBody2D

var target
export (int) var speed
var BULLET = preload('res://objects/BulletTorret1.tscn')
var time
var is_timer = false
var bullets = 15
var delta_angle
var prev_rot

func get_pos(x,y,angle):
	var xn = cos(angle)*x - sin(angle)*y
	var yn = sin(angle)*x + cos(angle)*y
	return Vector2(xn, yn)

func _ready():
	target = null
	time = Timer.new()
	time.connect('timeout', self, 'timeout_fire')
	time.set_wait_time(0.8)
	add_child(time)
	delta_angle = 0
	prev_rot = 0

func _process(delta):
	if target:
		# rotate and shoot
		var enemy_dir = (target.global_position - $Sprite.global_position).normalized()
		var cur_dir = Vector2(0,-1).rotated($Sprite.global_rotation)
		# global_rotation = cur_dir.linear_interpolate(enemy_dir,speed).angle()
		$Sprite.global_rotation = cur_dir.linear_interpolate(enemy_dir,speed).angle()
		
		"""
		if (prev_rot - $Sprite.global_rotation) != 0:
			print('delta_angle::',delta_angle)
			print('$Sprite global_rotation::', $Sprite.global_rotation)
			print('prev_rot::', prev_rot)
			delta_angle = prev_rot - $Sprite.global_rotation
			prev_rot = $Sprite.global_rotation
		"""
		if is_timer:
			time.start()
			is_timer = false
		
	pass

func timeout_fire():
	if bullets > 0:
		fire()
	else:
		time.stop()


func fire():
	var bulletL = BULLET.instance()
	var bulletR = BULLET.instance()
	var enemy_dir = (target.global_position - global_position).normalized()
	
	# BUG it keeps spinning, and is rotating in the oposite angle
	# $LeftT.position = get_pos($LeftT.position.x, $LeftT.position.y, $Sprite.global_rotation - $LeftT.global_rotation)
	# $RightT.position = get_pos($RightT.position.x, $RightT.position.y, $Sprite.global_rotation - $RightT.global_rotation)
	delta_angle = 0
	
	bulletL.position = $Sprite/LeftT.position
	bulletR.position = $Sprite/RightT.position
	bulletL.setup(enemy_dir)
	bulletR.setup(enemy_dir)
	
	add_child(bulletL)
	add_child(bulletR)
	
	bullets = bullets - 1
	

func _on_Vision_body_entered(body):
	if body.get_name() == "Player":
		print("Body PLAYER is in vision")
		target = body
		is_timer = true


func _on_Vision_body_exited(body):
	if body.get_name() == "Player":
		print("Body PLAYER is out of vision")
		target = null
		bullets = 15
		is_timer = false
		time.stop()
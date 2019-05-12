extends StaticBody2D

var target
export (int) var speed
var BULLET = preload('res://objects/BulletTorret1.tscn')
var time

func _ready():
	target = null
	time = Timer.new()
	time.connect('timeout', self, 'timeout_fire')
	time.set_wait_time(0.2)

func _process(delta):
	if target:
		# rotate and shoot
		var enemy_dir = (target.global_position - global_position).normalized()
		var cur_dir = Vector2(0,-1).rotated(global_rotation)
		global_rotation = cur_dir.linear_interpolate(enemy_dir,speed).angle()
		
		# Play animation. and fire. Try to sync
		fire()
		#time.start()
		
	pass

func timeout_fire():
	fire()


func fire():
	var bulletL = BULLET.instance()
	var bulletR = BULLET.instance()
	var enemy_dir = (target.global_position - global_position).normalized()
	
	bulletL.global_position = $LeftT.position
	bulletR.global_position = $RightT.position
	# bulletL.setup(enemy_dir)
	# bulletR.setup(enemy_dir)
	add_child(bulletL)
	add_child(bulletR)
	

func _on_Vision_body_entered(body):
	if body.get_name() == "Player":
		target = body


func _on_Vision_body_exited(body):
	if body.get_name() == "Player":
		target = null
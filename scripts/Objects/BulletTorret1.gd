extends KinematicBody2D

var direction
signal bullet_hit(body)
var speed = 120
var isset = false
var damage = 5
var timer_handler
signal hit(body)
var anim_handler

func _ready():
	anim_handler = get_node("Sprite/AnimationPlayer/AnimationTree").get("parameters/playback")
	timer_handler = Timer.new()
	timer_handler.connect("timeout", self, "lifetime_out")
	timer_handler.set_wait_time(2)
	add_child(timer_handler)
	pass

func setup(dir):
	if not isset:
		direction = dir
		isset = true
		anim_handler.start("rotate")
		timer_handler.start()

func _process(delta):
	if isset:
		move_and_slide(direction * speed, Vector2(0,0))
		pass
	pass

func _on_Area2D_body_entered(body):
	# animation and hit
	print("AREA OF BULLET")
	print(name)
	emit_signal("bullet_hit",body)
	if body.name== "Player":
		playerdata.stats["health"]=playerdata.stats["health"]-damage
	anim_handler.travel("explode")
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()
	pass # Replace with function body.

func lifetime_out():
	anim_handler.travel("explode")
	pass
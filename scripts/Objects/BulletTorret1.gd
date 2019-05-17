extends KinematicBody2D

var direction
signal bullet_hit(body)
var speed = 120
var isset = false
var damage = 5
signal hit(body)

func _ready():
	pass

func setup(dir):
	if not isset:
		direction = dir
		isset = true

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
	queue_free()
	pass # Replace with function body.

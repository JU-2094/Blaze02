extends KinematicBody2D

var direction
signal bullet_hit(body)
var speed = 120
var isset = false
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
	emit_signal("bullet_hit", body)
	
	# removing node
	# get_parent().remove_child(self)
	queue_free()
	pass # Replace with function body.

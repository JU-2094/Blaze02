extends KinematicBody2D

var direction
signal bullet_hit(body)
var speed = 10
var time
signal hit(body)

func _ready():
	pass

func setup(dir):
	direction = dir

func _process(delta):
	move_and_slide(direction * speed, Vector2(0,0))
	
	pass

func _on_Area2D_body_entered(body):
	# animation and hit
	emit_signal("bullet_hit", body)
	
	# removing node
	# get_parent().remove_child(self)
	queue_free()
	pass # Replace with function body.

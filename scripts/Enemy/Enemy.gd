extends RigidBody2D
export (int) var speed
var intrud = RigidBody2D.new()
var sight= false
var velocity = Vector2()
var position2 = Vector2()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
func _process(delta):
	if sight==true:
		enemydirection()
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta
		#position.x = clamp(position.x, 0, screensize.x)
		#position.y = clamp(position.y, 0, screensize.y)
	if sight==true :
		sight=false
	pass

func _on_RayCast2D_follow(player):
	intrud=player
	sight=true
	pass # replace with function body
	
#function that updates the direction in wich the enemy is moving thowards
func enemydirection():
	position2= intrud.get_transform().origin - self.get_transform().origin
	if position2.x>0:
		velocity.x += 1
	if position2.x<0:
		velocity.x -= 1
	if position2.y<0:
		velocity.y -= 1
	if position2.y>0:
		velocity.y += 1
	pass
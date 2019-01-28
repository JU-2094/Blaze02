extends KinematicBody2D
export (int) var speed
var intrud = KinematicBody2D.new()
var isfollow = false
var istime =  false
var follow_count
var velocity = Vector2()
var direction = Vector2()
var origin_vector


func _ready():
	origin_vector = get_transform().origin
	follow_count = 120
	pass

func _physics_process(delta):	
	if isfollow:
		enemydirection()
		# isfollow = false
	elif istime and (follow_count > 0):
		enemydirection()
		follow_count -= 1
	else:
		returnorigin()
		istime = false
	if not isfollow:
		follow_count -= 1
	#position += velocity * delta
	move_and_slide(velocity, Vector2(0,0))

func _on_RayCast2D_follow(player):
	isfollow = true
	istime = true
	follow_count = 120
	intrud=player

func _on_Vision_body_exited(body):
	if body.get_name() == "Player":
		velocity.x = 0
		velocity.y = 0
		isfollow = false
		istime = true
		

#function that updates the direction in wich the enemy is moving thowards
func enemydirection():
	velocity = intrud.get_transform().origin - self.get_transform().origin
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func returnorigin():
	velocity = origin_vector - self.get_transform().origin
	if velocity.length() > 2:
		velocity = velocity.normalized() * speed
	else:
		velocity.x = 0
		velocity.y = 0


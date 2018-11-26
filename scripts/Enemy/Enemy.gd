extends KinematicBody2D
export (int) var speed
var intrud = KinematicBody2D.new()
var isfollow= false
var velocity = Vector2()
var direction = Vector2()

func _ready():
	pass

func _physics_process(delta):	
	if isfollow:
		enemydirection()
		isfollow = false
	#position += velocity * delta
	move_and_slide(velocity, Vector2(0,0))

func _on_RayCast2D_follow(player):
	isfollow = true
	intrud=player

func _on_Vision_body_exited(body):
	if body.get_name() == "Player":
		velocity.x = 0
		velocity.y = 0
		isfollow = false

#function that updates the direction in wich the enemy is moving thowards
func enemydirection():
	velocity = intrud.get_transform().origin - self.get_transform().origin
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


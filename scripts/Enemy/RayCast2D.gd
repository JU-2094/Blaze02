extends RayCast2D
var intrudloc=Vector2()
var flag = true
var intrud = RigidBody2D.new()
signal follow(player)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#Function that is called every frame
func _process(delta):
	if intrud.get_name()=="Player":
		follow_enemy(intrud)
	if self.is_colliding():
		var collider = self.get_collider()
		if collider.get_name()=="Player":
			emit_signal("follow",collider)
		if  Input.is_action_pressed('ui_print'):
			print("collision with:",collider.get_name())
	pass

#Function that modifies the raycast casting target
func follow_enemy(enemy):
	#print("following enemy:",enemy.get_name())
	intrudloc=enemy.get_transform().origin -get_node("../").get_transform().origin
	cast_to=intrudloc
	pass


#Function that recieves the intruder signal from the vision field of the enemy.
func _on_Vision_intruder(enemy):
	#print(location)
	#print("tu estas aqui",get_node("../").get_transform().origin)
	intrud=enemy
	print(intrud.get_name())
	pass # replace with function body

#function that shows with whom object the raycast is colliding
func showcol():

	pass
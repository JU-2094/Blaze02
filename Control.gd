extends Control

# class member variables go here, for example:
# var a = 2
var c = false
var cimgwapon
var cimgitem
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization her
	for item in playerdata.items:
		var imgitem = load(itemdata.items[item])
		$Panel/ItemList.add_item(item,imgitem)
	cimgitem = load(itemdata.items[playerdata.cur_item])
	$Panel/VBoxContainer/Currentitems/item2.texture=cimgitem
	
	for weapon in playerdata.weapons:
		var weapons = load(itemdata.weapon[weapon])
		$Panel/VBoxContainer2/ItemList2.add_item(weapon,weapons)
	cimgwapon = load(itemdata.weapon[playerdata.cur_weapon])
	$Panel/VBoxContainer/Currentitems/item1.texture=cimgwapon

	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _input(event):
	if  event.is_action_pressed("ui_pause") :
		get_tree().paused = not get_tree().paused 
		print("true")
		if get_tree().paused:
			$Panel.show()
		else:
			$Panel.hide()
	pass

func _on_Exit_pressed():
	get_tree().quit()
	pass # replace with function body


func _on_Return_pressed():
	print("entra button")
	if get_tree().paused and c:
		c=false
		$Panel.hide()
		get_tree().paused = false
	else:
		c=true
	
	pass # 

func _on_ItemList2_item_selected(index):
	playerdata.cur_weapon=$Panel/VBoxContainer2/ItemList2.get_item_text(index)
	cimgwapon = load(itemdata.weapon[playerdata.cur_weapon])
	$Panel/VBoxContainer/Currentitems/item1.texture=cimgwapon
	#playerdata.cur_weapon=$Panel/ItemList.get_item_text(index)
	#var cimgwapon = load(itemdata.weapon[playerdata.cur_weapon])
	#$Panel/VBoxContainer/Currentitems/item1.texture=cimgwapon
	pass # Replace with function body.


func _on_ItemList_item_selected(index):
	print($Panel/ItemList.get_item_text(index))
	playerdata.cur_item=$Panel/ItemList.get_item_text(index)
	cimgitem = load(itemdata.items[playerdata.cur_item])
	$Panel/VBoxContainer/Currentitems/item2.texture=cimgitem

	pass # Replace with function body.

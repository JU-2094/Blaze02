extends Control

# class member variables go here, for example:
# var a = 2
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization her
	for item in playerdata.items:
		var imgitem = load(itemdata.items[item])
		$Panel/ItemList.add_item(item,imgitem)
	var cimgwapon = load(itemdata.weapon[playerdata.cur_weapon])
	$Panel/VBoxContainer/Currentitems/item1.texture=cimgwapon
	var cimgitem = load(itemdata.items[playerdata.cur_item])
	$Panel/VBoxContainer/Currentitems/item2.texture=cimgitem
	for weapon in playerdata.weapons:
		var weapons = load(itemdata.weapon[weapon])
		$Panel/VBoxContainer2/ItemList2.add_icon_item(weapons)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

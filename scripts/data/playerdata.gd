extends Node
var maxstats = {"health":100, "mana":100,"stamina":100,"lives":10}
var maxitems = {"bombs":10, "bullets":50,"coins":100,"grass":10}
var stats = {"health":100, "mana":100,"stamina":100,"lives":3}
var items = {"bombs":10,"coins":100,"gems":1,"bluepotion":0}
var powerups = {"speedup":false}
var weapons = {"sword":true,"wand":false,"shield":false,"axe":false}
var cur_item = "bombs"
var cur_weapon = "sword"
var cur_item_res = {"bombs": 'Bomb', "sword": 'Weapon'}
# 13 states for player
# 5 states for bomb
var anim = {"player":["right", "left", "up", "down", "carry_right", "carry_left", "carry_up", "carry_down", "grab_down", \
					"sword_right", "sword_left", "sword_up", "sword_down"], \
			"bombs":["bomb_up", "throw_bomb_right", "throw_bomb_left", "throw_bomb_up", "throw_bomb_down"]}
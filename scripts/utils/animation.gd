extends Node

"""
	play_anim
		Receives as input the state, node and dictionary with the values with the names of the
		animations to be executed and checked for the state
"""
func play_anim(state, node, anim_arr, stop = false):
	if stop:
		node.stop()
	else:
		if node.current_animation != anim_arr[state]:
			node.play(anim_arr[state])

func play_anim_item(state, node, anim_arr, item_count = 0, node_item = null, anim_item_arr = null, state_item = 0):
	var node_item_anim = null
	if node.current_animation != anim_arr[state]:
		if item_count > 0 and (node_item != null) and (anim_item_arr != null):
			node_item.visible = true
			node_item_anim = node_item.get_node('AnimationPlayer')
			node_item_anim.play(anim_item_arr[state_item])
		node.play(anim_arr[state])


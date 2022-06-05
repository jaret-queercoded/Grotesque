extends StaticBody

export var interaction_text = "Press E to open chest"
export var can_interact = true
export var has_required_item = false
export var required_item = "test_key"
export var contained_items = ["test_item"]

var player

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	
func interact():
	#TODO Play a sound for opening the openable
	if !has_required_item or player.has_item(required_item):
		player.remove_item(required_item)
		#TODO instead of just deleting the chest I want to leave an open chest behind
		for item in contained_items:
			player.add_item(item, GameData.item_data[item])
		queue_free()
	#TODO play a sound a display a dialog when you try to open and you don't have the reqiured item
	player.interacting = false

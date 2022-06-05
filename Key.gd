extends Area

export var item_name = "test_key"

export var interaction_text = "Press E to pickup key"
export var can_interact = true

var player

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	
func interact():
	player.add_item(item_name, GameData.item_data[item_name])
	player.interacting = false
	queue_free()

extends StaticBody

export var interaction_text = "Press E to open chest"
export var can_interact = true
export var has_required_item = false
export var required_item = "test_key"

var player

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	
func interact():
	if !has_required_item or player.has_item(required_item):
		player.remove_item(required_item)
		queue_free()
	else:
		continue
	player.interacting = false

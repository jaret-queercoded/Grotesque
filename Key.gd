extends Spatial

export var item_name = "test_key"

func _on_PickUpArea_body_entered(body):
	if body.get_name() == "Player":
		body.add_item(item_name, GameData.item_data[item_name])

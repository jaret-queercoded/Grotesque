extends Node

var item_data = {}

func _ready():
	var file = File.new()
	file.open("res://GameData/items.json", File.READ)
	var items_json = JSON.parse(file.get_as_text())
	file.close()
	item_data = items_json.result

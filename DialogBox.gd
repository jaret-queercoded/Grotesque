extends Control

var dialog

var dialog_index = 0
var finished = false
var player

var dialog_path

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	
	#read the dialog from a file
	var file = File.new()
	
	file.open(dialog_path, file.READ)
	var text = file.get_as_text()
	file.close()
	
	var data_parse = JSON.parse(text)
	if data_parse.error != OK:
		push_error("Couldn't load file: ")
		return
	
	dialog = data_parse.result

func _physics_process(delta):
	$"FinishedIndicator".visible = finished
	if Input.is_action_just_pressed("interact"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$DialogText.bbcode_text = "[center]" + dialog[dialog_index] + "[/center]"
		$DialogText.percent_visible = 0
		$Tween.interpolate_property(
			$DialogText, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		
		$Tween.start()
	else:
		player.interacting = false
		#get_parent().reset_interaction()
		queue_free()
	
	dialog_index += 1

func _on_Tween_tween_completed(object, key):
	finished = true

extends Control

var dialog

var text_speed = 0.1
var dialog_index = 0
var finished = false
var player

var dialog_path
var interaction_sound_path
var audio_stream_player
var pitch

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	
	#read the dialog from a file
	var file = File.new()
	if !file.file_exists(dialog_path):
		push_error("File does not exsist: " + dialog_path)
		return
	
	file.open(dialog_path, file.READ)
	var text = file.get_as_text()
	file.close()
	
	var data_parse = JSON.parse(text)
	if data_parse.error != OK:
		push_error("Couldn't load file: " + dialog_path)
		return
	
	dialog = data_parse.result
	
	#get the audio stream path so that we can change it by who calls the dialog
	if !file.file_exists(interaction_sound_path):
		push_error("File does not exsist: " + dialog_path)
		return
	var sfx = load(interaction_sound_path)
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = sfx
	audio_stream_player.playing = false
	audio_stream_player.pitch_scale = pitch
	add_child(audio_stream_player)

func _physics_process(delta):
	$"FinishedIndicator".visible = finished
	if Input.is_action_just_pressed("interact"):
		load_dialog()

func load_dialog():
	audio_stream_player.playing = true
	if dialog_index < dialog.size():
		finished = false
		$DialogText.bbcode_text = dialog[dialog_index]
		$DialogText.percent_visible = 0
		$Tween.interpolate_property(
			$DialogText, "percent_visible", 0, 1, len(dialog[dialog_index]) * text_speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		
		$Tween.start()
	else:
		player.interacting = false
		#get_parent().reset_interaction()
		queue_free()
	
	dialog_index += 1

func _on_Tween_tween_completed(_object, _key):
	audio_stream_player.playing = false;
	finished = true

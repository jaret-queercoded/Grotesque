extends KinematicBody

var target

var speed = 1

var original_direction_target

var player
var interact_label

var can_interact = false

export var dialog_json_path = "res://dialog/test.json"
export var interaction_sound_path = "res://audio/test.ogg"

export var pitch = 1.0

const DIALOG = preload("res://DialogBox.tscn")

func _ready():
	original_direction_target = transform.origin
	original_direction_target.z -= .01
	
	player = get_tree().get_root().get_node("Main").get_node("Player")
	interact_label = get_tree().get_root().get_node("Main").get_node("InteractLabel")

func _input(event):
	if Input.is_action_just_pressed("interact") and can_interact:
		can_interact = false
		interact_label.visible = false
		var dialog = DIALOG.instance()
		dialog.dialog_path = dialog_json_path
		dialog.interaction_sound_path = interaction_sound_path
		dialog.pitch = pitch
		get_parent().add_child(dialog)
		player.interacting = true

func _physics_process(delta):
	if target:
		look_at_target(target.transform.origin, delta)
	
	else:
		look_at_target(original_direction_target, delta)


func look_at_target(target_position, delta):
	# since I don't want the person to tilt looking at the player I use the
	# same y value as the person so that they think that they are on the 
	# height level even though the player position is slightyly lower
	target_position.y = transform.origin.y
	
	# I could use look_at but I don't because it snaps the person to look at
	# the player and I perfer a smooth look at the player to fix this I get
	# the transform to make the person look at the player and instead I 
	# interpolate using the speed and the time delta to smoothly look at the
	# player
	var new_transform = transform.looking_at(target_position, Vector3.UP)
	transform  = transform.interpolate_with(new_transform, speed * delta)


func _on_LookAtArea_body_entered(body):
	if body.get_name() == "Player":
		target = body
		interact_label.visible = true
		can_interact = true

func _on_LookAtArea_body_exited(body):
	if body.get_name() == "Player":
		target = null
		interact_label.visible = false
		can_interact = false

func reset_interaction():
	can_interact = true
	interact_label.visible = true

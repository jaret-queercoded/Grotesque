extends KinematicBody

const MOVE_SPEED = 5
const BACKWARDS_SLOWDOWN = 0.66
const TURN_SPEED = 180
const GRAVITY = 98
const MAX_FALL_SPEED = 30

var y_velocity = 0
var grounded = false

var interacting = false

var inventory = {}

func _ready():
	GameData.item_data

func _physics_process(delta):
	var backwards = false
	var move_dir = 0
	var turn_dir = 0
	
	if !interacting:
		if Input.is_action_pressed("turn_left"):
			turn_dir += 1
		if Input.is_action_pressed("turn_right"):
			turn_dir -= 1
		
		if Input.is_action_pressed("move_back"):
			move_dir += 1
			backwards = true
		if Input.is_action_pressed("move_forward"):
			move_dir -= 1
			backwards = false
	
	rotation_degrees.y += turn_dir * TURN_SPEED * delta
	
	var move_vec = global_transform.basis.z * MOVE_SPEED * move_dir
	if backwards:
		move_vec *= BACKWARDS_SLOWDOWN
	
	move_vec.y = y_velocity
	var _move = move_and_slide(move_vec, Vector3.UP)
	
	grounded = is_on_floor()
	y_velocity -= GRAVITY * delta
	if grounded:
		y_velocity = -0.1
	if y_velocity < -MAX_FALL_SPEED:
		y_velocity = -MAX_FALL_SPEED

func add_item(key, item):
	inventory[key] = item

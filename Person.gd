extends KinematicBody

var target

var speed = 1

func _physics_process(delta):
	if target:
		# get the position that we want to look at
		var target_position = target.transform.origin
		
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

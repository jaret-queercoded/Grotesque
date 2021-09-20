extends Area

var interact_node

func _on_LookAtArea_body_entered(body):
	if body.get_name() == "Player":
		get_parent().target = body

func _on_LookAtArea_body_exited(body):
	

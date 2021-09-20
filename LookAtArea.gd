extends Area

func _on_LookAtArea_body_entered(body):
	if body.get_name() == "Player":
		get_parent().target = body

func _on_LookAtArea_body_exited(body):
	if body.get_name() == "Player":
		get_parent().target = null

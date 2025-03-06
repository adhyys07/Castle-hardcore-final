extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#For Death Response
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("You died! bitch") # Replace with function body.
#		body.queue_free()
#		get_tree().change_scene_to_file("res://scene/global/try_again.tscn")


#For Attack Response
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attacks"):
		queue_free()

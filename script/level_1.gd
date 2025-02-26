extends Node2D



#func _on_area_2d_body_entered(body: Node2D) -> void:
#	get_tree().change_scene_to_file("res://scene/level_2.tscn") # Replace with function body.


func _on_level_portal_1_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scene/level_2.tscn") # Replace with function body.

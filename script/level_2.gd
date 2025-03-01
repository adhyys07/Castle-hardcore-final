extends Node2D



func _on_level_portal_2_body_entered(body: Player):
	get_tree().change_scene_to_file("res://scene/level_3.tscn")

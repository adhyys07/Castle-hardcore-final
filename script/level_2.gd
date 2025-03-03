extends Node2D

func _ready() -> void:
	Gamemanager.current_level_path = get_tree().current_scene.scene_file_path

func _on_level_portal_2_body_entered(body: Player):
	get_tree().change_scene_to_file("res://scene/level_3.tscn")
	
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/level_2.tscn") #Replace with function body.

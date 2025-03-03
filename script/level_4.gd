extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.current_level_path = get_tree().current_scene.scene_file_path# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_level_portal_3_body_entered(body: Player):
	get_tree().change_scene_to_file("res://scene/level_5.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/level_4.tscn")

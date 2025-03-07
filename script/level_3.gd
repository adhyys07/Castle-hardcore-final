extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.current_level_path = get_tree().current_scene.scene_file_path # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


	# Replace with function body.
	


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/World 1/level_3.tscn")
	



func _on_level_portal_3_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scene/World 1/level_4.tscn") # Replace with function body.

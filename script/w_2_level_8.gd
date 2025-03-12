extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.current_level_path = get_tree().current_scene.scene_file_pathpass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_14_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/World 2/w_2_level_8.tscn")

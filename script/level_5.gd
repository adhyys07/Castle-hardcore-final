extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.current_level_path = get_tree().current_scene.scene_file_path
	if not MusicManager.is_playing():
		MusicManager.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_portal_5_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scene/World 1/level_6.tscn") # Replace with function body.


func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/World 1/level_5.tscn")

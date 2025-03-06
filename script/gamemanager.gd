extends Node

var current_level_path = "" 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene:
		current_level_path = get_tree().current_scene.scene_file_path# Replace with function body.

func restart_level():
	if current_level_path != "":
		get_tree().change_scene_to_file(current_level_path)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal coin_collect(value: int)

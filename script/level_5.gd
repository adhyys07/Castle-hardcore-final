extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_portal_5_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scene/level_6.tscn") # Replace with function body.


func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/level_5.tscn")

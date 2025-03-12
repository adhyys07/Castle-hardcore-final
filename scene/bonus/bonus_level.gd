extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.current_level_path = get_tree().current_scene.scene_file_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bonus_portal_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scene/World 2/w_2_lvl_7_rbonus.tscn")

extends Node2D
@onready var popup_scene = preload("res://scene/global/shop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.current_level_path = get_tree().current_scene.scene_file_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bonus_portal_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scene/World 2/w_2_lvl_7_rbonus.tscn")


func _on_bonus_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/bonus/bonus_level.tscn")


func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/global/shop.tscn")

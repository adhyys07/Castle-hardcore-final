extends Node2D

@export var speed = 160.0
var current_speed = 0.0	

func _physics_process(delta: float):
	position.y += current_speed * delta

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		get_tree().change_scene_to_file("res://scene/global/try_again.tscn")


func _on_playerdetect_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		null
		
func fall():
	current_speed = speed
	await get_tree().create_timer(5).timeout
	queue_free()
		
		

extends Node2D

var new_player = preload("res://scene/playerskins/player_gsword.tscn").instantiate()

# popup.gd
func _ready():
	var close_button = $CloseButton
	close_button.pressed.connect(_on_close_pressed)

func _on_close_pressed():
	queue_free()


func _on_gsword_pressed() -> void:
	get_parent().add_child(new_player)
	queue_free() # Remove the current player scene



func _on_ghammer_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	visible = false # Replace with function body.

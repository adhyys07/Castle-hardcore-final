extends Node2D


# popup.gd
func _ready():
	var close_button = $CloseButton
	close_button.pressed.connect(_on_close_pressed)

func _on_close_pressed():
	queue_free()

extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.connect("pressed", Callable(self, "_on_button_pressed"))

func _input(event):
	if event.is_action_pressed("my_button_action"):
		_on_button_pressed()

func _on_button_pressed() -> void:
	Input.start_joy_vibration(0, 0.5, 0.2, 0.5)  # Vibrate for 0.2s
	get_tree().change_scene_to_file("res://scene/World 1/level_1.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

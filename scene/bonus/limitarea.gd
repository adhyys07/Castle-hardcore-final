extends Area2D

@onready var button = $shop_button

func _ready():
	button.disabled = true  # Disable button by default
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":  # Adjust the name to match your player node
		button.disabled = false

func _on_body_exited(body):
	if body.name == "Player":
		button.disabled = true

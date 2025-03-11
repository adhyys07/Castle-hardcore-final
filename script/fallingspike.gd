@onready var area = $Area2D
@onready var body = $RigidBody2D


func _ready():
	area = $Area2D
	body = $RigidBody2D
	body.gravity_scale = 0  # Keep it floating initially

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		fall()

func fall():
	body.gravity_scale = 1  # Enable gravity to make it fall

func _on_body_entered(body):
	if body.name == "Ground" or body.name == "Player":
		queue_free()  # Remove spike after impact


func _on_playerdetect_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

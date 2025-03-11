extends Area2D

@export var jump_force: float = 600.0

func _ready():
	connect("body_entered", _on_body_entered)
	

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.velocity.y = -jump_force
		$jump.play()

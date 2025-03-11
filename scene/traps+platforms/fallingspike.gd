extends Area2D

@export var fall_speed: float = 300.0
var is_falling = false

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	if is_falling:
		position.y += fall_speed * delta

func _on_body_entered(body):
	if body.name == "Player":
		is_falling = true
	
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scene/global/try_again.tscn")

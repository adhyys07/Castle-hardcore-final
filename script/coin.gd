extends Area2D

func _ready() -> void:
	pass
	
@export var value: int = 1
@onready var coin_sound: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Gamecontroller.coin_collected(value)
		coin_sound.play()
		queue_free()


		

extends Area2D

func _ready() -> void:
	pass
	
@export var value: int = 1
@onready var sound

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Gamecontroller.coin_collected(value)
		$pickupsfx.play()
		queue_free()


		

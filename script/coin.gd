extends Area2D

@export var coin_value: int = 1

func _ready() -> void:
	connect("body_entered", _on_body_entered)


func _on_body_entered(body):
	if body.is_in_group("player"):  # Ensure the player is in the correct group
		CoinManager.add_coin()
		SoundManager.play_coin_sound()
		queue_free()  # Remove the coin
		

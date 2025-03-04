extends PathFollow2D

@export var speed: float = 100.0  # Speed of movement
var direction: int = 1  # 1 = forward, -1 = backward

@onready var sprite = $AnimatedSprite2D  # Adjust based on your node structure

func _process(delta):
	progress += speed * direction * delta

	# Check if we reached the end
	if progress_ratio >= 1.0:
		direction = -1  # Reverse movement
		sprite.flip_h = true  # Flip animation

	# Check if we reached the start
	elif progress_ratio <= 0.0:
		direction = 1  # Move forward again
		sprite.flip_h = false  # Reset animation direction

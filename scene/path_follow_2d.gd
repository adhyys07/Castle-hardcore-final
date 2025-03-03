extends PathFollow2D

@export var speed: float = 100.0
var direction: int = 1  # Moving forward

@onready var anim = $AnimatedSprite2D  # Adjust if using another animation system

func _process(delta):
	progress += direction * speed * delta

	# If reached end, change animation
	if progress_ratio >= 1.0:
		direction = -1  # Reverse direction
		anim.play("left")  # Change to your animation

	elif progress_ratio <= 0.0:
		direction = 1  # Move forward
		anim.play("right")  # Back to moving animation

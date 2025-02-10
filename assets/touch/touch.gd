extends CharacterBody2D  # Use CharacterBody2D for Godot 4

# Movement variables
const MOVE_SPEED = 200
const JUMP_FORCE = -350
const GRAVITY = 900


var left = false
var right = false

# Called every frame
func _physics_process(delta):
	velocity.y += GRAVITY * delta  # Gravity effect

	# Handle horizontal movement
	if left:
		velocity.x = -MOVE_SPEED
	elif right:
		velocity.x = MOVE_SPEED
	else:
		velocity.x = 0

	# Apply movement and gravity
	move_and_slide()

# Button callbacks
func _on_left_button_pressed():
	left = true

func _on_left_button_released():
	left = false

func _on_right_button_pressed():
	right = true

func _on_right_button_released():
	right = false

func _on_jump_button_pressed():
	if is_on_floor():
		velocity.y = JUMP_FORCE

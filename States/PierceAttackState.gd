extends PlayerState

func EnterState():
	Name = "PierceAttack"
	if not Player.Animator.animation_finished.is_connected(_on_animation_finished):
		Player.Animator.animation_finished.connect(_on_animation_finished)

func ExitState():
	# Disconnect animation_finished to avoid unnecessary calls
	if Player.Animator.animation_finished.is_connected(_on_animation_finished):
		Player.Animator.animation_finished.disconnect(_on_animation_finished)

func Update(delta: float) -> void:
	Player.HorizontalMovement()  # Allow minor movement if needed
	Player.HandleFlipH()  # Flip sprite if needed
	HandleAnimations()

func HandleAnimations():
	Player.Animator.play("PierceAttack")

func _on_animation_finished():
	Player.ChangeState(States.Idle)  # Return to idle when animation ends

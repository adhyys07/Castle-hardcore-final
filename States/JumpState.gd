extends PlayerState

func EnterState():
	Name = "Jump"
	Player.velocity.y = Player.jumpVelocity

func ExitState():
	pass
	
func Update(delta: float) -> void:
	if Player.velocity.y > Player.JumpVelocity:  # Allow jump force to take effect
		Player.HandleGravity(delta)
	Player.HorizontalMovement()
	HandleJumpToFall()
	HandleAnimations()

	
func HandleJumpToFall():
	if Player.velocity.y >= 0:
		Player.ChangeState(States.JumpPeak)
		
func HandleAnimations():
	Player.Animator.play("Idle")
	Player.HandleFlipH()

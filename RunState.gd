extends PlayerState

func EnterState():
	Name = "Run"
	
func ExitState():
	pass
	
func Update(delta: float) -> void:
	Player.HorizontalMovement()
	Player.HandleJump()
	Player.HandleFalling()
	Player.HandlePierceAttack()
	HandleAnimations()
	HandleIdle()

func HandleIdle():
	if Player.moveDirection == 0:
		Player.ChangeState(States.Idle)
		
func HandleAnimations():
	Player.Animator.play("Run")
	Player.HandleFlipH

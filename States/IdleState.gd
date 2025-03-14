extends PlayerState

func EnterState():
	Name = "Idle"
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float) -> void:
	Player.HandleFalling()
	Player.HandleJump()
	Player.HorizontalMovement()
	Player.HandlePierceAttack()
	if Player.moveDirection != 0:
		Player.ChangeState(States.Run)
	HandleAnimations()
		
func HandleAnimations():
	Player.Animator.play("Idle")
	Player.HandleFlipH()

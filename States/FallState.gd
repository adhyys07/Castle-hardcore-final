extends PlayerState

func EnterState():
	Name = "Fall"
	
func ExitState():
	pass
	
func Update(delta: float) -> void:
	Player.HandleGravity(delta)
	Player.HorizontalMovement()
	Player.HandleLanding()
	HandleAnimations()
	
func HandleAnimations():
	Player.Animator.play("Idle")
	Player.HandleFlipH()

extends PlayerState

func EnterState():
	Name = "JumpPeak"
	
func ExitState():
	pass
	
func Update(delta: float) -> void:
	Player.ChangeState(States.Fall)	
	

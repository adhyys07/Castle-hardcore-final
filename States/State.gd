extends Node

@onready var Locked = $Locked
@onready var Idle = $Idle
@onready var Run = $Run
@onready var Jump = $Jump
@onready var JumpPeak = $JumpPeak
@onready var Fall = $Fall
@onready var PierceAttack = $PierceAttack
@onready var HammerAttack = $HammerAttack

var current_state: PlayerState = null

func change_state(new_state_name: String):
	var new_state = get_node(new_state_name)  # Get the state node

	if new_state and new_state != current_state:
		if current_state:
			current_state.ExitState()
		current_state = new_state
		current_state.EnterState()

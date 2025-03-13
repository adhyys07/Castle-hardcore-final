extends CharacterBody2D

#region Player Variables 
#nodes
@onready var Sprite = $Sprite2D
@onready var Collider = $CollisionShape2D
@onready var Animator = $Animator
@onready var States = $StateMachine

#Physics variables
const RunSpeed = 200
const Acceleration = 40
const Decelaration = 25
const Gravity = 500
const JumpVelocity = -315
const MaxJumps = 1

var moveSpeed = RunSpeed
var moveDirection = 0
var jumps = 0
var facing = 1

#Input variables
var jump = false
var left = false
var right = false
var down = false
var jumpPressed = false

#StateMachine
var currentState = null
var previousState = null

#endregion

#region Main Loop Functions

func _ready() -> void:
	# Initialize State Machine
	for state in States.get_children():
		if state is PlayerState:  # Ensure it's a valid PlayerState
			state.States = States
			state.Player = self

	previousState = States.Fall
	currentState = States.Fall

func _draw() -> void:
	currentState.Draw()

func _physics_process(delta: float) -> void:
	GetInputStates()
	
	currentState.Update(delta)
	
	HandleGravity(delta)
	HorizontalMovement()
	HandleJump()

	move_and_slide()
	
func ChangeState(newState):
	if newState != null:
		previousState = currentState
		currentState = newState
		previousState.ExitState()
		currentState.ExitState()
		print("State change from:" + previousState.Name + " to:" + currentState.Name)

#endregion		

#region Custom Functions

func GetInputStates():
	jump = Input.is_action_pressed("jump")
	down = Input.is_action_pressed("down")
	left = Input.is_action_pressed("left")
	right = Input.is_action_pressed("right")
	jumpPressed = Input.is_action_just_pressed("jump")
	
	if (right): facing = 1
	if (left): facing = -1
	
	

func HandleFalling():
	if !is_on_floor():
		ChangeState(States.Fall)

func HandleGravity(delta, gravity: float = Gravity):
	if !is_on_floor():
		velocity.y += Gravity * delta
	else:
		jumps = 0

func HandleJump():
	if jumpPressed and jumps < MaxJumps:
		velocity.y = JumpVelocity
		ChangeState(States.Jump)
		jumps += 1

func HorizontalMovement(acceleration: float = Acceleration, decelaration: float = Decelaration):
	moveDirection = Input.get_axis("left", "right")
	if moveDirection != 0:
		velocity.x = move_toward(velocity.x, moveDirection * moveSpeed, Acceleration)
	else:
		velocity.x = move_toward(velocity.x, moveDirection * moveSpeed, Decelaration)

func HandleLanding():
	if is_on_floor():
		jumps = 0
		ChangeState(States.Idle)

func HandleFlipH():
	Sprite.flip_h = facing < 1

#endregion

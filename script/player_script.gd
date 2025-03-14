class_name Player extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var healthbar = $Healthbar

const JUMP_VELOCITY = -315.0
@export var jump_force: float = -315.0
@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var attack = false
@export var isAttacking = false
@onready var hurtbox = $Area2D
@onready var floor_ray_cast: RayCast2D = $RayCast2D

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
const dash_speed = 500
const dash_duration = 0.2

@onready var dash = $Dash

@export var accelerationValue = 0.1 
@export var slideValue = 0.01
@export var FullStopValue = 15
var direction := Input.get_axis("left", "right")

var JumpBuffer: bool = false
@export var JumpBufferTime = 0.05
var JumpBufferTimer = 0.0

var coyote_time = 0.5
var can_jump = false
var health = 20
var knockback_force = 200

func _ready():
	#Gamemanager.player = self
	hurtbox.add_to_group("player")
	print("hurtx in group: ", hurtbox.get_groups())
	healthbar.init_health(health)
	hurtbox.area_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left", "right")

	if direction < 0:
		facing = -1
	elif direction > 0:
		facing = 1

	_normal_movement()

	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(sprite,dash_duration)

	moveSpeed = dash_speed if dash.is_dashing() else RunSpeed

	if !is_on_floor() and floor_ray_cast.is_colliding():
			$falling.play()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if is_on_floor() and can_jump == false:
		can_jump = true
	elif can_jump == true and $Timer/coyote_timer.is_stopped():
		$Timer/coyote_timer.start(coyote_time)
	else:
		JumpBuffer = true
		JumpBufferTimer = JumpBufferTime
		
	if JumpBuffer:
		JumpBufferTimer -= delta
		if JumpBufferTimer <= 0:
			JumpBuffer = false
			
	if JumpBuffer and is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
		JumpBuffer = false	
	
	if can_jump:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
			$jump.play()


	#if direction:
		#if isAttacking == false:
			#velocity.x = direction * speed
			#sprite.scale.x = -1 if direction < 0 else 1
			#sprite.play("walk")
	#else:
		#if isAttacking == false:
			#velocity.x = move_toward(velocity.x, 0, speed)
			#if is_on_floor():
				#sprite.play("idle")
	#
	if Input.is_action_just_pressed("pierce_attack"):
		$AnimatedSprite2D.play("pierce_attack")
		Input.start_joy_vibration(0,0.2,0.09,0.7)
		$AttackArea/Pierce.disabled = false
		$AttackArea/Pierce2.disabled = false
		$cooldown.start()
		$pierce_effect.play()
		isAttacking = true
	
	if Input.is_action_just_pressed("hammer_attack"):
		$AnimatedSprite2D.play("hammer_attack")
		Input.start_joy_vibration(0,0.2,0.09,0.7)
		$AttackArea/Hammer.disabled = false
		$AttackArea/Hammer2.disabled = false
		$cooldown.start()
		$hammer.play()
		isAttacking = true
	
	if Input.is_action_just_pressed("spin_attack"):
		$AnimatedSprite2D.play("spin_attack")
		Input.start_joy_vibration(0,0.2,0.09,0.7)
		$AttackArea/SpinAttack.disabled = false
		$AttackArea/SpinAttack2.disabled = false
		$cooldown.start()
		$spin.play()
		isAttacking = true	
	
	if Input.is_action_just_pressed("taunt"):
		$AnimatedSprite2D.play("taunt")
		Input.start_joy_vibration(0,0.2,0.09,0.7)
		$taunt.play()

	
	#Apply movement
		
	if _is_on_ice():
		_movement_on_ice(direction)
	else:
		_normal_movement(direction)
	
	#HandleFlipH()	
	move_and_slide()
	
	
func _movement_on_ice(direction):
	if direction:
		velocity.x = lerp(velocity.x, direction * speed, accelerationValue)
	else:
		velocity.x = lerp(velocity.x, 0.0, slideValue)
		
		if velocity.x < FullStopValue and velocity.x > -FullStopValue:
			velocity.x = 0
		
func _normal_movement(acceleration: float = Acceleration, decelaration: float = Decelaration):
	if !isAttacking:
		moveDirection = Input.get_axis("left", "right")
		if moveDirection != 0:
			velocity.x = move_toward(velocity.x, moveDirection * moveSpeed, Acceleration)
			sprite.play("walk")
			sprite.flip_h = direction < 1
		else:
			velocity.x = move_toward(velocity.x, moveDirection * moveSpeed, Decelaration)
			sprite.play("idle")
		
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collectible"):
		body.Collect()

func take_damage(amount,knockdown_direction):
	if dash.is_dashing(): return
	if isAttacking: return
	health -= amount
	health =  max(health,0)
	
	healthbar._set_health(health)
	velocity += knockback_force* knockdown_direction
	move_and_slide()
	healthbar.value = health 
	if health<=0:
		die()		
			
func mob_entered(body: Node2D) -> void:
	if body.is_in_group("mob"):
		var knockdown_direction = (global_position - body.global_position).normalized()
		take_damage(5,knockdown_direction)

			#print("youre gay")
		$Timer/coyote_timer
		#OS.delay_msec(1000)
		#get_tree().change_scene_to
		
func _input(event: InputEvent):
	if(event.is_action_pressed("ui_down")):
		position.y += 1
	if Input.is_action_just_pressed("emote"):
		_play_emote()
	if Input.is_action_just_released("emote"):
		_stop_emote()
		
func _play_emote():
	if not isAttacking and is_on_floor():
		sprite.play("taunt")
		isAttacking = true

func _stop_emote():
	if sprite.animation == "taunt":
		sprite.play("idle")  # Go back to idle or walking state
		isAttacking = false
		
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "pierce_attack":
		$AttackArea/Pierce.disabled = true
		$AttackArea/Pierce2.disabled = true
		isAttacking = false
	elif sprite.animation == "hammer_attack":
		$AttackArea/Hammer.disabled = true
		$AttackArea/Hammer2.disabled = true
		isAttacking = false
	elif sprite.animation == "spin_attack":
		$AttackArea/SpinAttack.disabled = true
		$AttackArea/SpinAttack2.disabled = true
		isAttacking = false
	#elif sprite.animation == "taunt":
		#sprite.play("idle")
		#isAttacking = false
	if $AnimatedSprite2D.animation == "death":
		get_tree().change_scene_to_file("res://scene/global/main_menu.tscn")
	


func die():
	animated_sprite.play("death")
	


func _on_coyote_timer_timeout() -> void:
	can_jump = false
	pass # Replace with function body.
	
func _is_on_ice():
	var collider = floor_ray_cast.get_collider()
	if not collider: return false
	return collider.name == "iceBlocks"
	#
#func HandleFlipH():
	#sprite.scale.x = -1 if direction < 1 else 1

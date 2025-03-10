class_name Player extends CharacterBody2D

@onready
var sprite = $AnimatedSprite2D
@onready var healthbar = $Healthbar

const JUMP_VELOCITY = -315.0
@export var jump_force: float = -315.0
@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var attack = false
@export var isAttacking = false
@onready var hurtbox = $Area2D
@onready var floor_ray_cast: RayCast2D = $RayCast2D

var JumpBuffer: bool = false
@export var JumpBufferTime = 0.2
var JumpBufferTimer = 0.0

var coyote_time = 0.3
var can_jump = false
var health = 20
var knockback_force = 200

func _ready():
	#Gamemanager.player = self
	healthbar.init_health(health)
	hurtbox.area_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta: float) -> void:
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

	
	var direction := Input.get_axis("ui_left", "ui_right")

		
	if direction:
		if isAttacking == false:
			velocity.x = direction * speed
			sprite.flip_h = direction < 0
			sprite.play("walk")
	else:
		if isAttacking == false:
			velocity.x = move_toward(velocity.x, 0, speed)
			if is_on_floor():
				sprite.play("idle")
	
	if Input.is_action_just_pressed("pierce_attack"):
		sprite.play("pierce_attack")
		$AttackArea/Pierce.disabled = false
		$AttackArea/Pierce2.disabled = false
		isAttacking = true
	#Apply movement
		
	if _is_on_ice():
		_movement_on_ice(direction)
	else:
		_normal_movement(direction)
		
func _movement_on_ice(direction):
	pass
		
func _normal_movement(direction):
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed) 
		
		
	move_and_slide()

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	
	
	if body.is_in_group("Collectible"):
		body.Collect()

func take_damage(amount,knockdown_direction):
	health -= amount
	health =  max(health,0)
	
	healthbar._set_health(health)
	velocity= knockback_force* knockdown_direction
	move_and_slide()
	
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
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "pierce_attack":
		$AttackArea/Pierce.disabled = true
		$AttackArea/Pierce2.disabled = true
		isAttacking = false
	if $AnimatedSprite2D.animation == "death":
		get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_button_7_pressed() -> void:
	pass # Replace with function body.
	
func die():
	queue_free()


func _on_coyote_timer_timeout() -> void:
	can_jump = false
	pass # Replace with function body.
	
func _is_on_ice():
	var collider = floor_ray_cast.get_collider()
	if not collider: return false
	return collider.name == "iceBlocks"

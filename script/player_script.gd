class_name Player extends CharacterBody2D

@onready
var sprite = $AnimatedSprite2D

const JUMP_VELOCITY = -315.0
@export var jump_force: float = -300.0
@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var attack = false
var attacking: bool = false

func _ready():
	add_to_group("player")
func _process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if attacking:
		move_and_slide()
		return  # Prevent movement & animation changes while attacking
		
	if direction:
		velocity.x = direction * speed
		sprite.flip_h = direction < 0
		sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			sprite.play("idle")

	if Input.is_action_just_pressed("attack"):
		sprite.play("attack")
		attacking = true
		
		sprite.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT)

	
	#Apply movement
		
	move_and_slide()
	
func _on_attack_finished():
	attacking = false  # Allow other animations after attack ends
	sprite.play("idle")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collectible"):
		body.Collect()
		


			
func mob_entered(body: Node2D) -> void:
	if body.is_in_group("mob"):
		animated_sprite.play("death")
		get_tree().change_scene_to_file("res://scene/main_menu.tscn")
			#print("youre gay")
		
		#OS.delay_msec(1000)
		#get_tree().change_scene_to
		
func _input(event: InputEvent):
	if(event.is_action_pressed("ui_down")):
		position.y += 1
		
func emote():
	if Input.is_action_just_released("emote"):
		animated_sprite.play("taunt")
		

	
	
	
	

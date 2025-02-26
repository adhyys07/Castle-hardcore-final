class_name Player extends CharacterBody2D

@onready
var sprite = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var attack = false

func _process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
	
	
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collectible"):
		body.Collect()
		

func attack2():
	attack = true
	animated_sprite.play("attack")
			
func mob_entered(body: Node2D) -> void:
	if body.is_in_group("mob"):
		get_tree().change_scene_to_file("res://scene/main_menu.tscn")
			#print("youre gay")
		#animated_sprite.play("death")
		#OS.delay_msec(1000)
		#get_tree().change_scene_to
		
func _process2(delta):
	if Input.is_action_just_pressed("attack"):
		attack2()
		

	
	

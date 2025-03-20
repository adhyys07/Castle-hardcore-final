extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@export var attack_delay: float = 0.5
@export  var shake_duration: float = 0.2
@export var  shake_intensity: float = 5.0
@onready var hurtbox = $hurtbox
@onready var attackzone = $attackzone
@onready var attack_hitbox = $attack_hitbox
@onready var debug_label = $Label
@onready var attack_timer = $Timer

var camera: Camera2D = null

var is_player_dead = false
var dealing_damage = false
var inside = false

var speed = 50
var attack_damage = 50
var is_attacking = false
var player = null

var health = 100
var current_health
var can_damage = true 

func _ready():
	camera = get_tree().get_first_node_in_group("main_camera")
	current_health = health
	attackzone.area_exited.connect(_on_attackzone_area_exited)
	
	animated_sprite.play("idle")
	
func _physics_process(delta: float) -> void:
	
	if player and can_damage and  not is_player_dead:
		var distance = global_position.distance_to(player.global_position) 
		if distance > 30:
			move_toward_player(delta)
		else:
			velocity = Vector2.ZERO
			
			
		
func move_toward_player(delta):
	if not player:
		return
		
	var direction = (player.global_position - global_position).normalized()
	if direction.x > 0:
		animated_sprite.flip_h =  true
		#attack_hitbox.position.x = abs(attack_hitbox.position.x)
	else:
		animated_sprite.flip_h = false
		#attack_hitbox.position.x = -abs(attack_hitbox.position.x)
	velocity = direction * speed
	
	
	move_and_slide()
	animated_sprite.play("walk")


	
'''func attack():
	if is_attacking or not player:
		return
	is_attacking = true
	animated_sprite.play("attack")	
	await animated_sprite.animation_finished
	
	if player and global_position.distance_to(player.global_position)< 50:
		player.take_damage(attack_damage)
	
	is_attacking = false'''
		
func take_damage1(amount):
	current_health -= amount
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	
	if current_health <= 0:
		die()
	else:
		animated_sprite.play("idle")
	
		
func die():
	animated_sprite.play("die")
	await animated_sprite.animation_finished
	
	queue_free()
	
'''func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack"):
		take_damage1(20)'''
	
	 # Replace with function body.
func attack_loop():
	if player.health<=0:
		return 
	while player and dealing_damage and player.health>0 and inside:
		can_damage = false
		animated_sprite.play("attack")
		await animated_sprite.animation_finished
		screen_shake()
		if player and player.health>0:
			var knockback_direction = (global_position - player.global_position).normalized()
			
			player.take_damage(attack_damage,knockback_direction)
		else: break
		animated_sprite.play("idle")
		if not is_inside_tree():
			break
		await  get_tree().create_timer(attack_delay).timeout
		can_damage = true
			
		


func _on_attackzone_area_entered(area: Area2D) -> void:
	print("some enter: ", area.name,"groups: ", area.get_groups())
	if area.is_in_group("player"):
		player = area.get_parent()
		print("boss detected player", player.name)
		
		

func _on_attackzone_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player = null
		
func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("player") and can_damage and not is_player_dead:
		player = area.get_parent()
		if player and player.health>0:
			inside = true
			can_damage = true
			dealing_damage = true
			attack_loop()
			


func update_debug_label(text: String):
	if debug_label:
		debug_label.text = text
func log_debug_message(msg):
	var label = get_node("Label") # Change to correct path
	label.text += msg + "\n"
	

func _on_attack_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		inside = false 

func screen_shake():
	if camera:
		var shake_time = shake_duration
		if shake_time >0:
			camera.offset = Vector2(randf_range(-shake_intensity,shake_intensity), randf_range(-shake_intensity,shake_intensity))
			await get_tree().create_timer(0.02).timeout
			shake_time -= 0.02
		camera.offset = Vector2.ZERO

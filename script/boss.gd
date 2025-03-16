extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var hurtbox = $hurtbox
@onready var attackzone = $attackzone
@onready var attack_hitbox = $attack_hitbox
@onready var debug_label = $Label
@onready var attack_timer = $Timer



var speed = 50
var attack_damage = 20
var is_attacking = false
var player = null

var health = 100
var current_health
var can_damage = true 

func _ready():
	current_health = health
	attackzone.area_exited.connect(_on_attackzone_area_exited)
	
	animated_sprite.play("idle")
	
func _physics_process(delta: float) -> void:
	if is_attacking:
		return
		
	if player and can_damage:
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
	


func _on_attackzone_area_entered(area: Area2D) -> void:
	print("some enter: ", area.name,"groups: ", area.get_groups())
	if area.is_in_group("player"):
		player = area.get_parent()
		print("boss detected player", player.name)
		
		

func _on_attackzone_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player = null
		
func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("player") and can_damage:
		can_damage = false
		is_attacking = true
		
		animated_sprite.play("attack")
		update_debug_label("attack")
		await  get_tree().create_timer(animated_sprite.get_animation_length("attack")).timeout
		animated_sprite.stop()
		update_debug_label("finished ")
		
		
		var knockdown_direction = (global_position - area.global_position).normalized()
		#print("50")
		var player_node = area.get_parent()
		print ("100")
		
		if player_node.has_method("take_damage"):
			player_node.take_damage(attack_damage,knockdown_direction)
			print("50")	
			update_debug_label("took damage")
		animated_sprite.play("idle")
		update_debug_label("waiting for timer")	
		
		attack_timer.start()
		update_debug_label("timer start")
		update_debug_label(attack_timer.time_left)
		await attack_timer.timeout
		update_debug_label("timer finished ")
		can_damage = true
		is_attacking = false
		update_debug_label("c dam")


func update_debug_label(text: String):
	if debug_label:
		debug_label.text = text
func log_debug_message(msg):
	var label = get_node("Label") # Change to correct path
	label.text += msg + "\n"
	
	
	
	
	
	
	
	
	
	
	

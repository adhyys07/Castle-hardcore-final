extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var hurtbox = $hurtbox
@onready var attackzone = $attackzone

var speed = 50
var attack_damage = 20
var is_attacking = false
var player = null

var health = 100
var current_health

func _ready():
	current_health = health
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)
	attackzone.area_entered.connect(_on_attackzone_area_entered)
	attackzone.area_exited.connect(_on_attackzone_area_exited)
	
	animated_sprite.play("idle")
	
func _physics_process(delta: float) -> void:
	if player and not is_attacking:
		if global_position.distance_to(player.global_position) <200:
			move_toward_player(delta)
		if global_position.distance_to(player.global_position) < 1:
			attack()
		
func move_toward_player(delta):
	if not player:
		return
		
	var direction = (player.global_position - global_position).normalized()
	velocity = direction* speed
	
	if velocity.length() >1:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
	move_and_slide()

	
func attack():
	if is_attacking or not player:
		return
	is_attacking = true
	animated_sprite.play("attack")	
	await animated_sprite.animation_finished
	
	if player and global_position.distance_to(player.global_position)< 50:
		player.take_damage(attack_damage)
	
	is_attacking = false
		
func take_damage(amount):
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
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack"):
		take_damage(20)
	
	 # Replace with function body.
	


func _on_attackzone_area_entered(area: Area2D) -> void:
	print("some enter: ", area.name,"groups: ", area.get_groups())
	if area.is_in_group("player"):
		player = area.get_parent()
		print("boss detected player", player.name)
		
		

func _on_attackzone_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player = null
		
	

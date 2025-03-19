extends Area2D
@export var damage: int = 10
@onready var animated_sprite = $AnimatedSprite2D
@export var damage_interval : float = 1.0
@export var attack_delay : float = 0.5
@export var shake_intensity : float= 5.0
@export var shake_duration : float= 0.2
var player_node: Node2D =  null
var camera: Camera2D = null
var player_dead = false
var dealing_damage = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_tree().get_first_node_in_group("main_camera")


func deal_damage_loop():
	print("damage")
	await get_tree().create_timer(attack_delay).timeout
	while player_node and dealing_damage:
		print(" damage called")
		player_node.take_damage(damage,Vector2.ZERO)
		screen_shake()
		await get_tree().create_timer(attack_delay).timeout


func _on_area_entered(area: Area2D) -> void:
	print("entered")
	if area.is_in_group("player") and not dealing_damage:
		print ("this too")
		player_node = area.get_parent()
		dealing_damage = true
		deal_damage_loop()
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_node = null
		dealing_damage = false
		
func screen_shake():
	if camera:
		print ("yes")
		var shake_time = shake_duration
		if shake_time >0:
			camera.offset = Vector2(randf_range(-shake_intensity,shake_intensity), randf_range(-shake_intensity,shake_intensity))
			print("shake")
			await get_tree().create_timer(0.02).timeout
			shake_time -= 0.02
		camera.offset = Vector2.ZERO
			


	
	
	
	
	
	
	
	
	

extends CharacterBody2D

@export var speed: float = 100  # Movement speed
@onready var ray_cast = $RayCast2D  # Downward RayCast2D

var initial_direction: int = 1  # Default direction (right)
var direction: int  # This will be set in _ready()
var can_move: bool


func _ready():
	# Reset direction when the scene is reloaded
	direction = initial_direction
	scale.x = 1 if direction == 1 else -1  # Ensure correct sprite orientation
	ray_cast.position.x = abs(ray_cast.position.x) * direction  # Reset RayCast2D position



func _physics_process(delta):
	if $AnimatedSprite2D.animation == "death":
		velocity = Vector2.ZERO
	else: 
		velocity.x = direction * speed
		move_and_slide()
		can_move = true
	
	# If no ground ahead OR if the mob hits a wall, flip direction
	if not ray_cast.is_colliding() or is_on_wall():
		flip_direction()

func flip_direction():
	direction *= -1
	scale.x *= -1
	ray_cast.position.x *= -1
	position.x += direction * 5  # Push slightly to prevent getting stuck

#for Death
func _on_area_2d_body_entered(body: Node2D):
	if (body.name == "Player"):
		print("You died! bitch") # Replace with function body.
		body.queue_free()
		get_tree().change_scene_to_file("res://scene/global/try_again.tscn")

#For Attack respone
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attacks"):
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("death")

		
func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		queue_free()

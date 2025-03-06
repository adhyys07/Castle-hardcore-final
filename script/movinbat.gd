extends CharacterBody2D
const SPEED = 50
@onready var sprite = $AnimatedSprite2D
var direction = 1
var inverse = -1

func _ready():
	pass

func enemy_gravity(delta : float):
	if not is_on_floor():
		velocity += delta * get_gravity()

func rayc():
	if not $RayCast2D.is_colliding():
		direction = -direction
		$RayCast2D.position.x *= -1


func move_enemy():
	velocity.x = SPEED * direction 

func reverse_dir():
	if is_on_wall():
		direction = -direction
		
	
func _physics_process(delta: float) -> void:
	enemy_gravity(delta)
	move_enemy()
	move_and_slide()
	reverse_dir()
	rayc()


func _on_area_2d_body_entered(body: Player):
	print("You died! bitch") # Replace with function body.
	body.queue_free()
	get_tree().change_scene_to_file("res://scene/global/try_again.tscn")

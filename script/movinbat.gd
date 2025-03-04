extends CharacterBody2D
var direction = 1
const SPEED = 100

func enemy_float():
	velocity.x = direction * SPEED
	

func _on_timer_timeout() -> void:
	direction = -direction
	
func _physics_process(delta: float) -> void:
	enemy_float()
	_on_timer_timeout()
	move_and_slide()
	

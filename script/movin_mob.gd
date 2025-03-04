extends Path2D

@onready var sprite = $AnimatedSprite2D 
@export var loop = false
@export var speed = 2.0
@export var speed_scale = 2.0
@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not loop:
		animation.play("move")
		animation.speed_scale = speed_scale
		set_process(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.progress+=speed
 # Replace with function body.

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("You died! bitch") # Replace with function body.
		body.queue_free()
		get_tree().change_scene_to_file("res://scene/try_again.tscn")

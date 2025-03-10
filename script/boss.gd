extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
var health = 100

func _ready():
	animated_sprite.play("idle")
		

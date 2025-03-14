extends Node2D

const dash_delay = 0.4 

@onready var duration_timer = $DurationTimer
var can_dash = true
var ghost_scene = preload("res://scene/global/DashGhost.tscn")
var sprite

func start_dash(sprite, duration):
	self.sprite = sprite
	
	duration_timer.wait_time = duration
	duration_timer.start()

	#instance_ghost()
#
#func instance_ghost():
	#var ghost: Sprite2D = ghost_scene.instantiate()
	#get_parent().get_parent().add_child(ghost)
#
	#var current_frame_index = sprite.frame
	#var frame = sprite.frames.get_frame("walk", current_frame_index)
	#ghost.texture = frame
#
	#ghost.global_position = global_position
	##ghost.texture = sprite.texture
	##ghost.vframes = sprite.vframes
	##ghost.hframes = sprite.hrames
	##ghost.frame = sprite.frame
	#ghost.flip_h = sprite.flip_hD

func is_dashing():
	return !duration_timer.is_stopped()

func end_dash():
	can_dash = false
	await get_tree().create_timer(dash_delay).timeout
	can_dash = true
	
func _on_DurationTimer_timeout() -> void:
	end_dash()
	

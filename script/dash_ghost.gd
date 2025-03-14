extends Sprite2D

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.5)

	# Automatically free the node when the tween finishes
	tween.finished.connect(func(): queue_free())

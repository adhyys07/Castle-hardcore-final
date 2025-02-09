extends Control

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.connect("coin_collect", _on_event_coin_collect)


func _on_event_coin_collect(value: int) -> void:
	label.text = str(value)

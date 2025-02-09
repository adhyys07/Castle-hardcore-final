extends Node

var total_coins = 0

func coin_collected(value: int):
	total_coins += value 
	Gamemanager.emit_signal("coin_collect", total_coins)

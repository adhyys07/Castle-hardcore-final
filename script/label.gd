extends Label

func _process(delta):
	text = str(CoinManager.coins)

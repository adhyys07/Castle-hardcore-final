extends Label

func _process(delta):
	print("Updating Label: ", CoinManager.coins)  # Debug log
	text = str(CoinManager.coins)

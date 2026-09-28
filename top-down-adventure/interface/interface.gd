extends CanvasLayer

var coin_count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_coin_coin_collected(value: int) -> void:
	coin_count += 1
	$Control/CoinCount.text = str(coin_count)

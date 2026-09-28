extends Node

@onready var score_label: Label = $Interface/Control/CoinCount

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_coins_changed(total: int) -> void:
	score_label.text = str(total)

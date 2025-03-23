extends Node
class_name GameManager


# Signals
signal game_start()
signal game_end()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    get_node("../AnOtherNode").other_signal.connect()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

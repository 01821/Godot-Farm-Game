class_name Item extends Control

func _ready() -> void:
	FarmManager.clear_all_item_state.connect(_clear_all_item_state)

func _clear_all_item_state():
	pass

class_name UI extends CanvasLayer

@onready var money_label: Label = $Store/MoneyLabel

func _ready() -> void:
	money_label.text = str(FarmManager.money)
	FarmManager.money_change.connect(_update_money)
	AudioManager.play_bgm()
	
func _update_money(value:int):
	FarmManager.money += value
	money_label.text = str(FarmManager.money)
	

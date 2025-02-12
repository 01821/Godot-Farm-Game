@tool
class_name ToolButton extends Control

@export var tool_res:ToolRes

@onready var icon_back_ground: TextureRect = $IconBackGround
@onready var icon: TextureRect = $IconBackGround/Icon
@onready var price_label: Label = $PriceLabel

func _ready() -> void:
	update_res()

func update_res():
	if tool_res:
		icon.texture = tool_res.icon
		price_label.text = "￥" + str(tool_res.price)

func _on_button_pressed() -> void:
	FarmManager.SelectTool(self)

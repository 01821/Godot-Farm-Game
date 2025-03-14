class_name UI extends CanvasLayer

@onready var money_label: Label = $Store/MoneyLabel
const TOOL_SCENE = preload("res://scene/tool/tool.tscn")
var tool:Tool

func _ready() -> void:
	money_label.text = str(FarmManager.money)
	FarmManager.money_change.connect(_update_money)
	FarmManager.create_tool.connect(_create_tool)
	FarmManager.clear_all_mouse_target.connect(clear_tool)
	
	AudioManager.play_bgm()
	
func _update_money(value:int):
	FarmManager.money += value
	money_label.text = str(FarmManager.money)
	
func _create_tool():
	clear_tool()
	
	if FarmManager.select_tool_item:
		tool = TOOL_SCENE.instantiate()
		add_child(tool)
		tool.update_res(FarmManager.select_tool_item.tool_res)

func clear_tool():
	if tool:
		tool.queue_free()
		tool = null	

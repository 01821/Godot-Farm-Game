extends Node

signal money_change(value)

signal clear_all_item_state
signal clear_all_mouse_target #清除附着在鼠标的物品
signal create_tool

enum TOOL{None,Water,Fertilize,BuyPlot}

var select_plant_res:PlantRes
var select_tool_item:ToolItem
var money:int = 100

func _clear_all_item_state(res):
	if res is PlantRes:
		select_tool_item = null
	elif res is ToolRes:
		select_plant_res = null
		
	clear_all_item_state.emit()
	clear_all_mouse_target.emit()

'''生成跟随鼠标的工具'''
func _create_tool():
	create_tool.emit()

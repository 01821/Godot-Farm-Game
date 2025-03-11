extends Node

signal money_change(value)
signal clear_tool_item_state
signal clear_plant_item_state

enum TOOL{None,Water,Fertilize,BuyPlot}

var select_plant_res:PlantRes
var select_tool_item:ToolItem
var money:int = 100



func _clear_tool_item_state():
	select_tool_item = null
	clear_tool_item_state.emit()

func _clear_plant_item_state():
	select_plant_res = null
	clear_plant_item_state.emit()

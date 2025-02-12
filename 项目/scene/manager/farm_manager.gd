extends Node

@export var money : int = 100
@export var money_label:Label 
enum Tool{None,Water,Fertilize,BuyPlot}

var selectPlant:PlantItem
var isPlanting := false
var tool_is_selecting := false

var selectTool:ToolButton
var seletedToolType := Tool.None
var buy_btn_color := Color(0.19,0.7,0.4,1)
var cancel_btn_color := Color(1,0.3,0.25,1)

func _ready() -> void:
	money_label = get_tree().get_first_node_in_group("MoenyLabel")
	Transaction(0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

'''选择植物'''
func SelectPlant(newPlant:PlantItem):
	if selectPlant == newPlant:
		print("取消"+newPlant.plant_res.plantName)
		#newPlant.buy_button.text = "Buy"
		#update_btn_stylebox_color(newPlant.buy_button,buy_btn_color)
		#isPlanting = false
		#selectPlant = null
		clear_all_selection()
	else:
		#if selectPlant:
			#selectPlant.buy_button.text = "Buy"
			#update_btn_stylebox_color(selectPlant.buy_button,buy_btn_color)
		clear_all_selection()
		print("选择"+newPlant.plant_res.plantName)
		newPlant.buy_button.text = "Cancel"
		update_btn_stylebox_color(newPlant.buy_button,cancel_btn_color)
		selectPlant = newPlant
		isPlanting = true

func Transaction(count:int,production: float = 1.0):
	money += (count * production)
	money_label.text = "￥" + str(money)

func update_btn_stylebox_color(button:Button,color:Color):
	var new_stylebox_noraml = button.get_theme_stylebox("normal").duplicate()
	new_stylebox_noraml.bg_color = color
	button.add_theme_stylebox_override("normal",new_stylebox_noraml)
'''选择工具'''
func SelectTool(toolBtn:ToolButton):
	if toolBtn.tool_res.tool == seletedToolType:
		clear_all_selection()
	else:
		clear_all_selection()
		tool_is_selecting = true
		seletedToolType = toolBtn.tool_res.tool
		selectTool = toolBtn
		toolBtn.icon_back_ground.texture = toolBtn.tool_res.selectedButton
		
'''重置所有选择'''
func clear_all_selection():
	if isPlanting:
		isPlanting = false
		if selectPlant:
			selectPlant.buy_button.text = "Buy"
			update_btn_stylebox_color(selectPlant.buy_button,buy_btn_color)
			selectPlant = null
			
	if tool_is_selecting:
		if seletedToolType != Tool.None:
			selectTool.icon_back_ground.texture = selectTool.tool_res.normalButton
			
		tool_is_selecting = false
		seletedToolType = Tool.None
		selectTool = null

extends Node2D

@export var plant_res:PlantRes	#当前土地所种植的植物
@export var count_time:float	#记录时间
@export var no_watered_texture:Texture		#未浇水
@export var watered_texture:Texture			#有浇水
@export var unavailable_texture:Texture		#未开垦
@export var activeColor:Color #高亮颜色
@export var normalColor:Color #寻常颜色

@onready var plot_sprite: Sprite2D = $PlotSprite
@onready var plant_sprite: Sprite2D = $PlantSprite
@onready var tip_panel: TipPanel = $TipPanel

var is_planted := false #是否种植
var is_watered := false #是否浇水
var is_bought := false #是否开垦
var plant_stage := 0 #作物阶段
var production := 1.0 #土地产量

func _ready() -> void:
	if get_index() < 9:
		is_bought = true
	
	if is_bought:
		plot_sprite.texture = no_watered_texture
		tip_panel.show_tip_panel()
	else:
		plot_sprite.texture = unavailable_texture
		

func _process(delta: float) -> void:
	if is_planted and is_watered: #有作物并且浇水
		if plant_stage < len(plant_res.plantStageTexture) - 1: #尚未成熟
			count_time += delta
			if count_time >= plant_res.timeBtwStages:
				plant_stage += 1
				count_time = 0
				_update_plant_sprite()
		else:
			pass

func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("left_click"):
		if not is_planted and FarmManager.select_plant_res:
			if FarmManager.select_plant_res.price > FarmManager.money or not is_bought:
				return
			_plant()
		elif is_planted and plant_stage == len(plant_res.plantStageTexture) -1:
			_harvest()
		elif FarmManager.select_tool_item:
			if FarmManager.select_tool_item.tool_res.price > FarmManager.money:return
			match FarmManager.select_tool_item.tool_res.tool_type:
				FarmManager.TOOL.Water:
					if not is_bought:return
					is_watered = true
					plot_sprite.texture = watered_texture
					tip_panel.hide_tip_panel()
					AudioManager.play_water()
				FarmManager.TOOL.Fertilize:
					if not is_bought:return
					production = min(production + 0.2,2.0)
					AudioManager.play_fertilize()
				FarmManager.TOOL.BuyPlot:
					print("开垦")
					is_bought = true
					plot_sprite.texture = no_watered_texture
					AudioManager.play_buy_plot()
			FarmManager.money_change.emit(-FarmManager.select_tool_item.tool_res.price)
			
		
'''种植'''
func _plant():
	plant_res = FarmManager.select_plant_res
	is_planted = true
	plant_sprite.show()
	plant_stage = 0
	_update_plant_sprite()
	FarmManager.money_change.emit(-plant_res.price)

'''收获'''
func _harvest():
	print("收获")
	is_planted = false
	is_watered = false
	tip_panel.show_tip_panel()
	plot_sprite.texture = no_watered_texture
	plant_sprite.texture = null
	plant_sprite.hide()
	plant_stage = 0
	FarmManager.money_change.emit(plant_res.sell_money * production)
	production = 1.0

func _update_plant_sprite():
	if is_watered:
		plot_sprite.texture = watered_texture
	else:
		plot_sprite.texture = no_watered_texture
		
	plant_sprite.texture = plant_res.plantStageTexture[plant_stage]
	var offset_y = -plant_res.plantStageTexture[plant_stage].region.size.y / 2
	plant_sprite.position.y = offset_y


func _on_click_area_mouse_entered() -> void:
	plot_sprite.modulate = activeColor
	plant_sprite.modulate = activeColor
	
func _on_click_area_mouse_exited() -> void:
	plot_sprite.modulate = normalColor
	plant_sprite.modulate = normalColor

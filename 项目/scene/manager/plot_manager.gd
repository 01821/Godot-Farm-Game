extends Node2D

@export var plant:Sprite2D
@export var plant_res:PlantRes
@export var normalColor:Color
@export var activeColor:Color
@export var dryTexture:Texture
@export var normalTexture:Texture
@export var unavailableTexture:Texture

@onready var timer: Timer = $Timer
@onready var plot_texture: Sprite2D = $plotTexture

var is_planted := false
var plantStage := 0
var is_dry := true
var production := 1.0
var is_bought := false

func _ready() -> void:
	if get_index() < 9:
		is_bought = true
		
	if is_bought:
		plot_texture.texture = dryTexture
	else:
		plot_texture.texture = unavailableTexture
		
		
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if is_planted:
			if plantStage == len(plant_res.plantStageTextures) - 1 and not FarmManager.isPlanting and not FarmManager.tool_is_selecting:
				HarvestPlant()
		elif FarmManager.isPlanting and FarmManager.selectPlant.plant_res.buyPrice <= FarmManager.money and is_bought:
			Plant(FarmManager.selectPlant.plant_res)
			
		if FarmManager.tool_is_selecting:
			match FarmManager.seletedToolType:
				FarmManager.Tool.Water:
					if is_bought:
						is_dry = false
						plot_texture.texture = normalTexture
						if is_planted:
							UpdatePlant()
				FarmManager.Tool.Fertilize:
					if FarmManager.money >= FarmManager.selectTool.tool_res.price and is_bought:
						if production < 2: production += 0.2
						FarmManager.Transaction(-FarmManager.selectTool.tool_res.price)
				FarmManager.Tool.BuyPlot:
					if FarmManager.money >= FarmManager.selectTool.tool_res.price and not is_bought:
						FarmManager.Transaction(-FarmManager.selectTool.tool_res.price)
						is_bought = true
						plot_texture.texture = dryTexture

func _on_area_2d_mouse_entered() -> void:
	
	modulate = activeColor

func _on_area_2d_mouse_exited() -> void:
	modulate = normalColor

'''收获'''
func HarvestPlant():
	is_planted = false
	plant.hide()
	FarmManager.Transaction(plant_res.sellPrice,production)
	is_dry = true
	plot_texture.texture = dryTexture
	production = 1.0
	print("收获")
'''种植'''
func Plant(newPlantRes:PlantRes):
	plant_res = newPlantRes
	is_planted = true
	plant.show()
	FarmManager.Transaction(-newPlantRes.buyPrice)
	plantStage = 0
	UpdatePlant()
	print("种植")
	
func UpdatePlant():
	if is_dry:
		plant.texture = plant_res.dryPlanted
	else:
		plant.texture = plant_res.plantStageTextures[plantStage]
	var offset_y = -plant_res.plantStageTextures[plantStage].region.size.y / 2
	plant.position.y = offset_y
	timer.wait_time = plant_res.timeBtwStages
	timer.start()

func _on_timer_timeout() -> void:
	if plantStage < len(plant_res.plantStageTextures) - 1 and not is_dry:
		plantStage += 1
		UpdatePlant()

class_name PlantItem extends Control

@export var plant_res:PlantRes

@onready var icon: TextureRect = $IconBackground/Icon
@onready var plant_name: Label = $PlantName
@onready var plant_price: Label = $PlantPrice
@onready var buy_button: Button = $BuyButton

func _ready() -> void:
	FarmManager.clear_plant_item_state.connect(update_button_state)

'''更新资源'''
func update_res():
	if plant_res:
		icon.texture = plant_res.icon
		plant_name.text = plant_res.plantName
		plant_price.text = "$" + str(plant_res.price)

func _on_buy_button_pressed() -> void:
	FarmManager._clear_tool_item_state()
	update_button_state()
	if FarmManager.select_plant_res != plant_res:
		FarmManager.select_plant_res = plant_res
		buy_button.text = "Cancel"
	else:
		FarmManager.select_plant_res = null
		buy_button.text = "Buy"
		
	
func update_button_state():
	var plant_items = get_tree().get_nodes_in_group("PlantItem")
	for plant_item : PlantItem in plant_items:
		plant_item.buy_button.text = "Buy"

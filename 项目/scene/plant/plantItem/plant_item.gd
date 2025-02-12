@tool
class_name PlantItem extends Control

@export var plant_res:PlantRes


@onready var icon: TextureRect = $IconBackGround/Icon
@onready var plant_name: Label = $PlantName
@onready var plant_price: Label = $PlantPrice
@onready var buy_button: Button = $BuyButton

#func _ready() -> void:
	#update_res()
	
func update_res():
	if plant_res:
		icon.texture = plant_res.icon
		plant_name.text = plant_res.plantName
		plant_price.text = "$" + str(plant_res.buyPrice)


func _on_buy_button_pressed() -> void:
	FarmManager.SelectPlant(self)

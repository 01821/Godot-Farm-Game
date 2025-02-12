class_name PlantStore extends VBoxContainer

const PLANT_ITEM_SCENE = preload("res://scene/plant/plantItem/plant_item.tscn")
var plants_res_path:String = "res://resources/plants/"
var plants_res_array:Array[PlantRes]
func _ready() -> void:
	dir_plants_res(plants_res_path)
'''遍历植物资源目录，加载商店UI'''
func dir_plants_res(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("发现目录：" + file_name)
			else:
				print("发现文件：" + file_name)
				var resource = ResourceLoader.load(path + file_name)
				if resource is PlantRes:
					plants_res_array.append(resource)
			file_name = dir.get_next()
	else:
		print("尝试访问路径时出错。")
		
	plants_res_array.sort_custom(sort_by_price)
	for plant_res:PlantRes in plants_res_array:
		create_plant_item(plant_res)
		
func create_plant_item(plant_res:PlantRes):
	var plant_item:PlantItem = PLANT_ITEM_SCENE.instantiate()
	add_child(plant_item)
	plant_item.plant_res = plant_res
	plant_item.update_res()

func sort_by_price(res1:PlantRes,res2:PlantRes) -> bool:
	return res1.buyPrice < res2.buyPrice
	
func sort_by_time(res1:PlantRes,res2:PlantRes) -> bool:
	return res1.timeBtwStages < res2.timeBtwStages

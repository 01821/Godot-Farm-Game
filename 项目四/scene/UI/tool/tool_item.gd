class_name ToolItem extends Item

@export var tool_res:ToolRes
@onready var icon: TextureRect = $IconBackground/Icon
@onready var price_label: Label = $PriceLabel
@onready var icon_background: TextureRect = $IconBackground

func _ready() -> void:
	super()
	_update_res()

func _update_res():
	if tool_res:
		icon.texture = tool_res.icon
		price_label.text = "$" + str(tool_res.price)
		
func _on_button_pressed() -> void:
	FarmManager._clear_all_item_state(self.tool_res)
	if FarmManager.select_tool_item != self:
		FarmManager.select_tool_item = self
		icon_background.texture = tool_res.select_icon_bg
	else:
		FarmManager.select_tool_item = null
		icon_background.texture = tool_res.not_select_icon_bg
	
	FarmManager._create_tool()

'''清空状态'''
func _clear_all_item_state():
	var tool_items = get_tree().get_nodes_in_group("ToolItem")
	for tool_item:ToolItem in tool_items:
		tool_item.icon_background.texture = tool_res.not_select_icon_bg

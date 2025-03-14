class_name Tool extends Sprite2D

var tool_res:ToolRes

func update_res(res):
	tool_res = res
	if tool_res:
		texture = tool_res.icon

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

class_name TipPanel extends PanelContainer

@onready var sprite: Sprite2D = $Sprite2D
var tip_tween:Tween

func _ready() -> void:
	hide_tip_panel()

func show_tip_panel():
	if tip_tween != null:
		tip_tween.kill()

	tip_tween = create_tween()
	tip_tween.tween_property(self,"self_modulate",Color(1,1,1,0.5),0.5)
	await tip_tween.finished
	sprite.show()

func hide_tip_panel():
	self_modulate = Color(1,1,1,0)
	sprite.hide()

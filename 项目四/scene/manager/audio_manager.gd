extends Node

@onready var water: AudioStreamPlayer = $Water
@onready var fertilize: AudioStreamPlayer = $Fertilize
@onready var buy_plot: AudioStreamPlayer = $BuyPlot
@onready var bgm: AudioStreamPlayer = $Bgm

func play_bgm():
	bgm.play()

func stop_bgm():
	bgm.stop()

func play_water():
	water.play()
	
func play_fertilize():
	fertilize.play()

func play_buy_plot():
	buy_plot.play()

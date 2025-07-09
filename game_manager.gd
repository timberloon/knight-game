extends Node

var score = 0
@onready var coincounter: Label = $"../CanvasLayer/UI/coincounter"
@onready var healthcounter: Label = $"../CanvasLayer/healthpanel/healthcounter"

func addscore():
	score+=1
	coincounter.text = str(score)

func damage(health:int):
	healthcounter.text = str(health)
	

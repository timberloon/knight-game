extends Node

var score = 0
@onready var coincounter:Label
@onready var healthcounter:Label


func addscore():
	score+=1
	coincounter.text = str(score)

func damage(health:int):
	healthcounter.text = str(health)
	
func set_labels(coinlabel: Label,healthlabel:Label) -> void:
	coincounter = coinlabel
	healthcounter = healthlabel

extends Node

#Walls, Stairs, Floors, Ceilings
var RequestedCloseShop = false
var ThingsNeeded = [133, 4, 52, 87]
var ThingsShipped = [0,0,0,0]
var thingsOnVan = [0,0,0,0]

func _process(delta: float) -> void:
	if ThingsNeeded[0] < 0:
		ThingsNeeded[0] = 0
	if ThingsNeeded[1] < 0:
		ThingsNeeded[1] = 0
	if ThingsNeeded[2] < 0:
		ThingsNeeded[2] = 0
	if ThingsNeeded[3] < 0:
		ThingsNeeded[3] = 0

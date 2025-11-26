extends VehicleBody3D
var playerOnTruck = false
var playerCan = false
var max_rpm = 500
var max_torque = 450
@export var player: Node3D
@export var Map: Node3D
@export var main: Node3D
@onready var area_3d: Area3D = $"./Area3D"
@onready var camera: Camera3D = $Camera3D
@export var ui: Control
signal BLOCK
signal UNBLOCK
func _physics_process(delta: float) -> void:
	if playerOnTruck == true:
		steering = lerp(steering, Input.get_axis("right", "left") * 0.45, 5 * delta)
		var acceleration = Input.get_axis("down", "up")
		var rpm = $Back_left.get_rpm()
		$Back_left.engine_force = acceleration * max_torque * (1 - rpm/ max_rpm)
		rpm = $Back_left.get_rpm()
		$Back_right.engine_force = acceleration * max_torque * (1 - rpm/ max_rpm)
	if Input.is_action_just_pressed("Hop"):
		print("pressed", playerCan, playerOnTruck)
	
		if playerOnTruck == true and playerOnTruck == false:
			print("hop out")
			playerOnTruck = false                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
			playerCan = true
			player.global_position += global_position + Vector3(2,1,0)
			self.freeze = true
			UNBLOCK.emit()
			camera.current = false
		else:
			if playerCan == true:
				print("hop")
				playerOnTruck = true
				playerCan = false
				self.freeze = false
				BLOCK.emit()                                                                                                                                                                            	                                                                                       
				camera.current = true

	var lappingbodies = area_3d.get_overlapping_bodies()

	if lappingbodies.has(player):
		playerCan = true
	else:
		playerCan = false
	var Mapa = Map.get_child(2).get_child(1).get_child(7).get_overlapping_bodies()
	if Mapa.has(self):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if not GlobalVariables.RequestedCloseShop == true:
			ui.get_child(1).visible = true
	var Finish = Map.get_child(5).get_overlapping_bodies()
	if Finish.has(self):
		GlobalVariables.ThingsNeeded[0] -= GlobalVariables.thingsOnVan[0]
		GlobalVariables.ThingsNeeded[1] -= GlobalVariables.thingsOnVan[1]
		GlobalVariables.ThingsNeeded[2] -= GlobalVariables.thingsOnVan[2]
		GlobalVariables.ThingsNeeded[3] -= GlobalVariables.thingsOnVan[3]
		GlobalVariables.thingsOnVan[0] = 0
		GlobalVariables.thingsOnVan[1] = 0
		GlobalVariables.thingsOnVan[2] = 0
		GlobalVariables.thingsOnVan[3] = 0
		
		print(GlobalVariables.ThingsNeeded)
		if not main.get_child(1).current == true and GlobalVariables.ThingsNeeded[0] == 0 and GlobalVariables.ThingsNeeded[1] == 0 and GlobalVariables.ThingsNeeded[2] == 0 and GlobalVariables.ThingsNeeded[3] == 0:
			print("you win")
			#main.get_child(1).get_child(0).play("a")
			ui.get_child(2).visible = true
			ui.get_child(2).get_child(0).play("disco")
			ui.get_child(2).get_child(0).play("show")
			main.get_child(3).visible = true
			
			print(ui.get_child(2))
			self.get_child(6).current = false
			main.get_child(1).current = true
			

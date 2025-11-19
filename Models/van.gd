extends VehicleBody3D
var playerOnTruck = false
var playerCan = false
var max_rpm = 400
var max_torque = 200
@export var player: Node3D
@onready var area_3d: Area3D = $"./Area3D"
@onready var camera: Camera3D = $Camera3D
signal BLOCK
signal UNBLOCK
func _physics_process(delta: float) -> void:
	if playerOnTruck == true:
		steering = lerp(steering, Input.get_axis("right", "left") * 0.3, 5 * delta)
		var acceleration = Input.get_axis("down", "up")
		var rpm = $Back_left.get_rpm()
		$Back_left.engine_force = acceleration * max_torque * (1 - rpm/ max_rpm)
		rpm = $Back_left.get_rpm()
		$Back_right.engine_force = acceleration * max_torque * (1 - rpm/ max_rpm)
	
	if Input.is_action_just_pressed("Hop"):
		print("pressed", playerCan, playerOnTruck)
	
		if playerOnTruck == true:
			print("hop out")
			playerOnTruck = false
			playerCan = true
			player.position = self.position + Vector3(2.5,1,1.5)
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

	print(player)
	var lappingbodies = area_3d.get_overlapping_bodies()
	print(lappingbodies.has(player))
	if lappingbodies.has(player):
		playerCan = true
	else:
		playerCan = false

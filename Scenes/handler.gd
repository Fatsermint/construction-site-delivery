extends Control
@onready var deliveryShop: TextureRect = $DeliveryShop
var DeliverListOpen = true
	#Walls, Stairs, Floors, Ceilings
var pending:Dictionary = {
	"walls": 0,
	"stairs": 0,
	"ceilings": 0,
	"floors": 0,
}
func _ready() -> void:
	var parents = [$DeliveryShop/walls, $DeliveryShop/floors, $DeliveryShop/stairs, $DeliveryShop/ceilings]
	for parent in parents:
		print(parent)
		for button in parent.get_children():
			if button is not Button:
				continue
			button.pressed.connect(func ():
				pending[parent.name] += int(button.name)
				print(pending["walls"])
			)
			
func _process(delta: float) -> void:
	var DeliveryListTween = create_tween()
	if Input.is_action_just_pressed("OpenDeliveryList"):
		if DeliverListOpen == true:
			DeliveryListTween.tween_property($"Delivery List", "position", Vector2(-400,110), 0.3)
			DeliverListOpen = false
		else:
			DeliveryListTween.tween_property($"Delivery List", "position", Vector2(0,110),0.3)
			DeliverListOpen = true
	#Walls, Stairs, Floors, Ceilings
	$"Delivery List/Label".text = "Walls: " + str(GlobalVariables.ThingsNeeded[0]) + " \nStairs: " + str(GlobalVariables.ThingsNeeded[1]) + " \nFloors: " + str(GlobalVariables.ThingsNeeded[2]) + " \n Ceilings: " + str(GlobalVariables.ThingsNeeded[3])
	if GlobalVariables.RequestedCloseShop == true:
		GlobalVariables.RequestedCloseShop = false
		deliveryShop.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_ready_pressed() -> void:
	GlobalVariables.RequestedCloseShop = true
	print(pending)
	#Walls, Stairs, Floors, Ceilings
	GlobalVariables.thingsOnVan[0] = pending["walls"]
	GlobalVariables.thingsOnVan[1] = pending["stairs"]
	GlobalVariables.thingsOnVan[2] = pending["floors"]
	GlobalVariables.thingsOnVan[3] = pending["ceilings"]
	print(GlobalVariables.thingsOnVan)
	

func _on_close_pressed() -> void:
	GlobalVariables.RequestedCloseShop = true
	pending = {
	"walls": 0,
	"stairs": 0,
	"ceilings": 0,
	"floors": 0,
	}
	print(pending)

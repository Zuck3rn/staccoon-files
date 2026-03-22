extends Control

var shopOpen = false

var itemList := ["Speedy Shoes","AA Battery", "Pogo Stick", "God Mode","Headband","Magnet"]

var availableItems := []

@export var shopList = ["AA Battery", "Speedy Shoes", "Pogo Stick"]

var shop = []

@export var coins = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refreshShop()
	visible = false

func refreshShop() -> void:
	shop = [$"Item 1",$"Item 2",$"Item 3"]
	availableItems.clear()
	for item in itemList:
		availableItems.append(item)
	for index in shop.size():
		var i = randi_range(0,availableItems.size()-1)
		var item = availableItems[i]
		shopList[index] = item
		availableItems.remove_at(i)
	for index in shopList.size():
		updateShop(index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if shopOpen and Input.is_action_just_pressed("escape"):
		print("shop has closed")
		visible = false


func _on_main_open_shop() -> void:
	print("Shop is Open")
	visible = true
	shopOpen = true


func _on_stack_stack_added() -> void:
	refreshShop()


func updateShop(index: int) -> void:
	match shopList[index]:
			"AA Battery":
				shop[index].Description.text = "AA Battery\nCost: 1\nMake your dash a little Faster"
				shop[index].texture_normal = preload("res://sprites/Battery.png")
			"Speedy Shoes":
				shop[index].Description.text = "Speedy Shoes\nCost: 4\nDoubles your Walk Speed"
				shop[index].texture_normal = preload("res://sprites/SpeedyShoes.png")
			"Pogo Stick":
				shop[index].Description.text = "Pogo Stick\nCost: 20\nGives you an extra jump"
				shop[index].texture_normal = preload("res://sprites/PogoStick.png")
			"God Mode":
				shop[index].Description.text = "God Mode\nCost: 99\nMultiplies all Stats by 10"
				shop[index].texture_normal = preload("res://sprites/GodPowers.png")
			"Headband":
				shop[index].Description.text = "Headband\nCost: 2\nMakes you Jump a little Higher"
				shop[index].texture_normal = preload("res://sprites/Headband.png")
			"Magnet":
				shop[index].Description.text = "Magnet\nCost: 6\nIncreases Coins you get from adding to the Stack"
				shop[index].texture_normal = preload("res://sprites/Magnet.png")
			"":
				shop[index].Description.text = ""
				shop[index].texture_normal = null

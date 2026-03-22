extends StaticBody2D

class_name stackObject

@export var type : String
var oldtype : String
@export var texture : Texture2D
var height : int = 0
var size := Vector2(1,1)
@export var box : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_type(type)

func get_type() -> String:
	return type

func set_type(intype : String):
	print("set_type called for " + intype)
	type = intype
	$ManHole.set_deferred("disabled", true)
	$Umbrella.set_deferred("disabled", true)
	$JetPack.set_deferred("disabled", true)
	$DivingR.set_deferred("disabled", true)
	$DivingL.set_deferred("disabled", true)
	match type:
		"umbrella":
			texture = preload("res://sprites/Table.png")
			height = 100
			$Umbrella.set_deferred("disabled", false)
			size = Vector2(.1,.1)
		"jetpack":
			texture = preload("res://sprites/JetPack.png")
			height = 30
			$JetPack.set_deferred("disabled", false)
			size = Vector2(.05,.05)
		"manhole":
			texture = preload("res://sprites/ManHole.png")
			height = 40
			$ManHole.set_deferred("disabled", false)
			size = Vector2(.05,.05)
		"divingR":
			texture = preload("res://sprites/DivingBoard.png")
			height = 34
			$DivingR.set_deferred("disabled", false)
			size = Vector2(.1,.1)
		"divingL":
			texture = preload("res://sprites/DivingBoardFlip.png")
			height = 34
			$DivingL.set_deferred("disabled", false)
			size = Vector2(.1,.1)
		_:
			texture = null
			height = 0
			size = Vector2(1,1)
	$Sprite2D.texture = texture
	$Sprite2D.scale = size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

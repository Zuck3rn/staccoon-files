extends Node2D

@export var stack : Array[String] = []
var object : stackObject

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in stack:
		var stackItem = preload("res://stackable_object.tscn").instantiate()
		stackItem.type = item
		add_child(stackItem)
		stackItem.position = $Top.position + Vector2(0,-12)
		$Top.position.y -= stackItem.height
	print(stack)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_item_to_stack(obj) -> void:
	stack.append(obj.type)
	var stackItem = preload("res://stackable_object.tscn").instantiate()
	stackItem.type = obj.type
	add_child(stackItem)
	stackItem.position = $Top.position - Vector2(0,stackItem.height/2) 
	$Top.position.y -= stackItem.height
	print(object)

func _on_top_body_entered(body: Node2D) -> void:
	if body.get_child(0).is_class("StaticBody2D") && (body.velocity.y >= 0 || stack.size() == 0):
		object = body.get_child(0)
		if not object.type.match("none"):
			body.velocity.y = 0
			body.global_position.y = $Top.global_position.y - 1.5*2*object.height - 50
			body.global_position.x = $Top.global_position.x
			add_item_to_stack(object)
			object.set_type("none")
			stack_added.emit()
signal stack_added()

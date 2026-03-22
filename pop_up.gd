extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if visible:
		var player = get_node("/root/Main/Player")
		position = player.global_position + Vector2(-80,-80)

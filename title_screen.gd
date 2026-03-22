extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://intro.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_mute_button_pressed() -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), not AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))


func _on_skip_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

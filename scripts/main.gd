extends Node3D

const GltfSceneLoaderScript = preload("res://scripts/gltf_loader.gd")

@onready var model_root: Node3D = $ModelRoot

var _loader: GltfSceneLoader
var _loaded_scene: Node3D
var _animation_player: AnimationPlayer
var _status_label: Label
var _path_input: LineEdit
var _animation_select: OptionButton
var _play_button: Button
var _file_dialog: FileDialog


func _ready() -> void:
	_loader = GltfSceneLoaderScript.new()
	_build_ui()
	_set_status("Ready. Load a local .glb or .gltf model to begin.")


func _build_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	var panel := PanelContainer.new()
	panel.position = Vector2(16, 16)
	panel.custom_minimum_size = Vector2(390, 0)
	layer.add_child(panel)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 8)
	panel.add_child(layout)

	var heading := Label.new()
	heading.text = "Project SEKAI 3D MV Player"
	heading.add_theme_font_size_override("font_size", 20)
	layout.add_child(heading)

	var hint := Label.new()
	hint.text = "Phase 0 · GLB / glTF preview"
	hint.modulate = Color(0.65, 0.75, 0.9)
	layout.add_child(hint)

	_path_input = LineEdit.new()
	_path_input.placeholder_text = "res://assets/model.glb or user://model.glb"
	_path_input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(_path_input)

	var load_row := HBoxContainer.new()
	layout.add_child(load_row)

	var browse_button := Button.new()
	browse_button.text = "Browse…"
	browse_button.pressed.connect(_open_file_dialog)
	load_row.add_child(browse_button)

	var load_button := Button.new()
	load_button.text = "Load model"
	load_button.pressed.connect(_load_model_from_path)
	load_row.add_child(load_button)

	_animation_select = OptionButton.new()
	_animation_select.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_animation_select.item_selected.connect(_on_animation_selected)
	layout.add_child(_animation_select)

	var playback_row := HBoxContainer.new()
	layout.add_child(playback_row)

	_play_button = Button.new()
	_play_button.text = "Play"
	_play_button.pressed.connect(_toggle_playback)
	playback_row.add_child(_play_button)

	var stop_button := Button.new()
	stop_button.text = "Stop"
	stop_button.pressed.connect(_stop_playback)
	playback_row.add_child(stop_button)

	var reset_button := Button.new()
	reset_button.text = "Reset view"
	reset_button.pressed.connect(_reset_view)
	playback_row.add_child(reset_button)

	_status_label = Label.new()
	_status_label.text = "Ready"
	_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_status_label.custom_minimum_size = Vector2(350, 48)
	layout.add_child(_status_label)

	_file_dialog = FileDialog.new()
	_file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	_file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	_file_dialog.add_filter("*.glb", "glTF Binary")
	_file_dialog.add_filter("*.gltf", "glTF JSON")
	_file_dialog.file_selected.connect(_on_file_selected)
	add_child(_file_dialog)


func _open_file_dialog() -> void:
	_file_dialog.popup_centered_ratio(0.75)


func _on_file_selected(path: String) -> void:
	_path_input.text = path
	_load_model_from_path()


func _load_model_from_path() -> void:
	var result: Dictionary = _loader.load_scene(_path_input.text)
	if not result.get("ok", false):
		_set_status(str(result.get("error", "Unknown loading error.")))
		return

	if is_instance_valid(_loaded_scene):
		_loaded_scene.queue_free()
		_loaded_scene = null

	_loaded_scene = result["scene"] as Node3D
	model_root.add_child(_loaded_scene)
	_find_animation_player(_loaded_scene)
	_populate_animation_list()
	_set_status("Model loaded. Found %d animation(s)." % _animation_select.item_count)


func _find_animation_player(root: Node) -> void:
	_animation_player = null
	if root is AnimationPlayer:
		_animation_player = root as AnimationPlayer
		return

	for child in root.get_children():
		_find_animation_player(child)
		if _animation_player != null:
			return


func _populate_animation_list() -> void:
	_animation_select.clear()
	if _animation_player == null:
		_animation_select.add_item("(No AnimationPlayer found)")
		_animation_select.disabled = true
		_play_button.disabled = true
		return

	var names := _animation_player.get_animation_list()
	for animation_name in names:
		_animation_select.add_item(animation_name)

	_animation_select.disabled = names.is_empty()
	_play_button.disabled = names.is_empty()
	if not names.is_empty():
		_animation_select.select(0)
		_animation_player.play(names[0])


func _on_animation_selected(index: int) -> void:
	if _animation_player == null:
		return
	var animation_name := _animation_select.get_item_text(index)
	if _animation_player.has_animation(animation_name):
		_animation_player.play(animation_name)
		_play_button.text = "Pause"


func _toggle_playback() -> void:
	if _animation_player == null:
		return
	if _animation_player.is_playing():
		_animation_player.pause()
		_play_button.text = "Play"
	else:
		var current := _animation_player.current_animation
		if current.is_empty() and _animation_select.item_count > 0:
			current = _animation_select.get_item_text(_animation_select.selected)
		if not current.is_empty():
			_animation_player.play(current)
		else:
			return
		_play_button.text = "Pause"


func _stop_playback() -> void:
	if _animation_player == null:
		return
	_animation_player.stop()
	_play_button.text = "Play"


func _reset_view() -> void:
	var camera := get_node_or_null("Camera3D") as Camera3D
	if camera != null:
		camera.position = Vector3(0, 1.4, 4.5)
		camera.rotation_degrees = Vector3(-10, 0, 0)


func _set_status(message: String) -> void:
	if _status_label != null:
		_status_label.text = message

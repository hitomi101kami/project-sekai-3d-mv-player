extends RefCounted
class_name GltfSceneLoader

## Loads a glTF 2.0 or GLB file into a scene node.
## The caller owns the returned node and is responsible for adding it to the scene tree.

func load_scene(path: String) -> Dictionary:
	if path.strip_edges().is_empty():
		return {"ok": false, "error": "Please enter a .glb or .gltf file path."}

	var extension := path.get_extension().to_lower()
	if extension != "glb" and extension != "gltf":
		return {"ok": false, "error": "Unsupported file type. The first player version accepts .glb and .gltf."}

	if not FileAccess.file_exists(path):
		return {"ok": false, "error": "File not found or inaccessible: %s" % path}

	var document := GLTFDocument.new()
	var state := GLTFState.new()
	var parse_error := document.append_from_file(path, state)

	if parse_error != OK:
		return {
			"ok": false,
			"error": "Could not parse glTF file (error %s)." % error_string(parse_error)
		}

	var generated_scene := document.generate_scene(state)
	if generated_scene == null:
		return {"ok": false, "error": "The glTF file was parsed but no scene could be generated."}

	return {
		"ok": true,
		"scene": generated_scene
	}

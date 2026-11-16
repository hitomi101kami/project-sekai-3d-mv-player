# Architecture

## 1. Runtime and platform strategy

The first implementation uses **Godot 4.x + GDScript** for a single runtime shared by Web and Android. The same scene tree, model representation, animation controls, camera controls, and playback state should behave consistently on both targets.

Platform-specific code is isolated behind small interfaces:

- `ModelSource`: obtains a model from a path, browser-selected file, Android-selected file, or app-managed storage.
- `SceneLoader`: turns a supported interchange file into a runtime scene.
- `PlaybackController`: controls animation playback and playback state.
- `PlatformFileAccess`: later adapter for Web and Android file selection/storage.

Do not put browser-only or Android-only assumptions in the 3D playback core.

## 2. Runtime data flow

```text
Source assets
    |
    v
Offline resource conversion (future)
    |  Unity assets / FBX / textures / animation
    v
Normalized interchange package
    |  GLB + JSON metadata
    v
Shared Godot runtime
    |-- Model / skeleton
    |-- Materials / textures
    |-- AnimationPlayer
    |-- Camera / lighting / stage
    v
Web export                 Android export
```

The initial runtime accepts standard **glTF 2.0 / GLB**. This avoids coupling the player to a proprietary game-asset layout and gives the converter a stable output contract.

## 3. Planned modules

| Module | Responsibility | Status |
|---|---|---|
| Runtime shell | App lifecycle and main UI | Scaffold |
| GLTF loader | Load .gltf/.glb scenes | Initial implementation |
| Playback controller | Play, pause, stop, select animation | Initial implementation |
| Model inspection | Scene tree, skeleton and mesh inspection | Planned |
| Resource parser | Unity bundle and source asset extraction | Planned |
| FBX normalizer | Mesh, skeleton, skinning and animation normalization | Planned |
| SEKAI rig adapter | Head/Body/Accessory assembly and rig mapping | Research |
| Morph adapter | BlendShape mapping and name recovery | Research |
| Material adapter | Texture and shader conversion | Planned |
| MV scene system | Stage, camera cuts, lighting and timeline | Planned |
| Web file adapter | Browser file selection and loading | Planned |
| Android file adapter | Android Storage Access Framework integration | Planned |

## 4. Source asset pipeline

The source parser is deliberately separate from the player. The converter should preserve original inputs and emit a normalized package:

- `model.glb`: geometry, skinning, materials, textures and supported animation tracks.
- `scene.json`: model parts, skeleton mapping, morph-name mapping, material overrides and provenance.
- Optional external textures or motion files only when they cannot be embedded efficiently.

Project SEKAI-specific handling will be added only after representative legally obtained test assets and their exact formats are inspected. Do not assume every FBX export has the same hierarchy or naming convention.

## 5. Important design constraints

- Keep the initial player independent of any one extraction tool.
- Do not silently discard unknown bones, morph targets, animation curves or material properties during conversion.
- Record unsupported features in conversion reports.
- Keep source-to-output mapping and conversion logs for debugging.
- Test Web and Android exports separately; browser sandbox and Android storage permissions differ.
- Avoid committing extracted proprietary game assets. Use small self-created or otherwise authorized test fixtures.

## 6. Initial acceptance criteria

1. The project opens in Godot 4.x without parse errors.
2. The main scene displays a 3D viewport and controls.
3. A valid local GLB/glTF file can be loaded by path.
4. Embedded animations can be listed and played/paused.
5. The same project can be exported to Web and Android after platform-specific export setup.

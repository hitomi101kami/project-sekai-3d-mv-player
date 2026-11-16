# Project SEKAI 3D MV Player

A cross-platform 3D character and motion viewer/player for the **Project SEKAI** asset workflow, targeting Web and Android from a shared Godot 4 project.

> **Project status:** Phase 0 scaffold. This repository does not yet contain Project SEKAI-specific asset decryption, extraction, rig repair, or a complete MV recreation pipeline.

## Goals

- One shared runtime for Web and Android.
- Load and inspect standard glTF 2.0 / GLB scenes as the first interchange format.
- Play animation tracks embedded in imported scenes.
- Build a separate, testable resource-conversion pipeline for source assets.
- Preserve user-provided source files; never require `sekai-assets-updater`.

## Initial technical direction

- **Engine:** Godot 4.x, GDScript.
- **Rendering:** Compatibility renderer as the initial cross-platform baseline; validate visual quality and performance on target devices.
- **Browser preview input:** FBX via Three.js FBXLoader; the first browser test supports exported FBX files.
- **Godot runtime interchange:** glTF 2.0 / GLB plus project JSON metadata.
- **Platforms:** Godot Web export and Android export from the same project.
- **Source asset pipeline:** initially documented interfaces; Unity asset extraction and Project SEKAI-specific FBX reconstruction are later phases.

## Repository layout

```text
project-sekai-3d-mv-player/
├── docs/                  # Architecture, formats, roadmap
├── scenes/                # Godot scenes
├── scripts/               # Runtime and loading logic
├── assets/                # User-provided test assets (not committed by default)
├── resource_parser/       # Future offline conversion tools
├── tests/                 # Test plans and automated tests
└── project.godot
```

## Run locally

1. Install Godot 4.x (standard build; no .NET version required).
2. Clone this repository.
3. Open `project.godot` in Godot.
4. Press **F6/F5** to run the main scene.
5. To test a model, enter a local `.glb` or `.gltf` path in the path field and select **Load**. The file must be accessible to the running Godot project.

The root `index.html` provides a browser-native FBX previewer with model orbit/zoom, animation selection, playback and a timeline. It uses Three.js FBXLoader and can accept external texture files selected alongside the FBX. The Godot project remains the planned shared Android/Web runtime and currently uses GLB/glTF as its interchange format.

## Current limitations

- No Project SEKAI proprietary bundle parser yet.
- No automatic FBX Head/Body/Accessory assembly yet.
- No CRC32 BlendShape-name recovery or shader conversion yet.
- No stage, camera choreography, lighting timeline, or complete 3DMV scene format yet.
- Loading a model is not the same as reproducing an original in-game MV.

See [Browser FBX Player](docs/WEB_PLAYER.md), [Architecture](docs/ARCHITECTURE.md) and [Roadmap](docs/ROADMAP.md).

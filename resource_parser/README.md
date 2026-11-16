# Resource Parser

This folder will contain offline conversion tools. It is intentionally separate from the Godot runtime.

## Contract

A converter accepts a source asset plus optional dependency files and emits a normalized package:

- one GLB scene containing supported geometry, skinning, materials, textures and animations;
- one versioned JSON manifest describing source provenance, part roles, skeleton mappings, morph mappings and conversion warnings;
- a machine-readable report listing unsupported features and missing dependencies.

Never overwrite source files. Never silently discard unknown data. The parser must not depend on the player's UI or scene tree.

Initial submodules:
- `fbx/`: FBX inspection and normalization.
- `unity_assets/`: future Unity container/serialized asset readers.
- `texture/`: future texture extraction and conversion.

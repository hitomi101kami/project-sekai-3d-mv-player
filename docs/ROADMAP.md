# Development Roadmap

## Phase 0 — Project foundation

- [x] Create repository and initial directory structure.
- [x] Select shared runtime direction (Godot 4.x).
- [x] Define GLB/glTF as the first runtime interchange format.
- [x] Add initial model loader and playback controls.
- [ ] Open project in Godot and run smoke test.
- [ ] Confirm target Godot minor version and renderer on a desktop build.
- [ ] Configure Web and Android export templates.

## Phase 1 — Basic 3D model player

- [ ] Robust GLB/glTF loading and error reporting.
- [ ] Animation list, play/pause/stop and animation switching.
- [ ] Camera orbit, zoom, pan and reset.
- [ ] Model visibility, transform and basic scene inspection.
- [ ] Web file selection and Android document picker.
- [ ] Test on desktop browsers and a real Android device.

## Phase 2 — Asset conversion foundation

- [ ] Collect a small set of authorized representative source assets.
- [ ] Document Unity container and serialized-file variants.
- [ ] Build parser interfaces and conversion report format.
- [ ] Import FBX and normalize mesh, skin, skeleton and materials.
- [ ] Convert normalized results to GLB plus JSON metadata.
- [ ] Add automated fixture tests.

## Phase 3 — Project SEKAI character assembly

- [ ] Inspect Head, Body and Accessory asset relationships.
- [ ] Map skeletons and validate neck/head attachment.
- [ ] Reconstruct skinned meshes without losing weights.
- [ ] Preserve and map BlendShape targets.
- [ ] Investigate CRC32-style morph identifiers where observed.
- [ ] Validate hair, face, eye, mouth and outfit materials.

## Phase 4 — MV playback system

- [ ] Define a versioned MV scene JSON schema.
- [ ] Stage and prop placement.
- [ ] Camera cuts and animated camera paths.
- [ ] Lighting and post-processing controls.
- [ ] Character motion synchronization.
- [ ] Audio timeline and timing synchronization.
- [ ] Timeline editor and preview controls.

## Phase 5 — Productization

- [ ] Project/library management.
- [ ] Asset validation and missing-dependency reports.
- [ ] Web deployment and Android packaging.
- [ ] Performance profiling and memory management.
- [ ] Documentation, sample project and release process.

## Milestone 0 exit gate

Do not start proprietary asset parsing until the basic GLB player opens, loads a test model, and plays at least one embedded animation on desktop. Web and Android file access must be validated independently before promising drag-and-drop or arbitrary local-file access.

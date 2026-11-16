# Test Plan

## Phase 0 smoke tests

- Open `project.godot` in the selected Godot 4.x stable release.
- Confirm the main scene runs without script or resource parse errors.
- Load a small, self-created GLB containing one mesh and one animation.
- Confirm the model appears in the viewport.
- Confirm the animation is listed and can be played, paused and stopped.
- Confirm a missing path and unsupported extension show readable errors.

## Cross-platform tests

- Export and run the same fixture on at least one desktop browser.
- Export and run the same fixture on a physical Android device.
- Verify file picker behavior separately on Web and Android.
- Record device, OS, browser, Godot version, renderer and asset size for each result.

## Regression fixtures

Use self-created or otherwise authorized assets. Do not commit proprietary game files to this repository.

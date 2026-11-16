# Android Platform

The Android build uses the same Godot project and playback core as Web.

Planned work:
- configure Android export templates, package ID, signing and permissions;
- integrate Android's Storage Access Framework for user-selected files;
- copy selected files and dependencies into app-managed storage where appropriate;
- profile memory, loading time, GPU compatibility and thermal behavior on physical devices.

Do not request broad storage permissions when a document-picker flow is sufficient.

# Web Platform

The Web build uses the same Godot project and playback core as Android.

Planned work:
- configure the Web export preset and deployment workflow;
- implement browser file selection and transfer into the app's virtual filesystem;
- validate memory limits for large character models and textures;
- test WebGL 2 / Compatibility renderer support across target browsers.

The current path-based loader is a developer workflow, not a finished browser upload experience.

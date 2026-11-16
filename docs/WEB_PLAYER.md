# Browser FBX Player

The root `index.html` is a separate browser-native FBX previewer built with Three.js and its FBXLoader. It is not the Godot runtime build.

## Run locally

Because the page uses JavaScript ES modules, serve the repository root over HTTP (do not open the HTML as a `file://` URL). For example:

```bash
python -m http.server 8000
```

Then open `http://localhost:8000`.

## Deploy with GitHub Pages

1. Open repository **Settings → Pages**.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Select branch `main` and folder `/(root)`, then Save.
4. After GitHub Pages finishes publishing, open:

   https://hitomi101kami.github.io/project-sekai-3d-mv-player/

## FBX input

Select one `.fbx` and, if it references external textures, select those image files in the same multi-file picker operation. The viewer attempts to resolve external textures by filename. Embedded texture support and complex FBX material/shader fidelity vary by source exporter.

The browser player currently previews standard FBX geometry, skinning and animation clips. It does not read encrypted Unity AssetBundles or proprietary Project SEKAI serialized files.

# Browser FBX Player

The root `index.html` is a browser-native FBX previewer built with Three.js and its FBXLoader. It is separate from the Godot runtime build.

## Run locally

Serve the repository root over HTTP (do not open the HTML as a `file://` URL):

```bash
python -m http.server 8000
```

Then open `http://localhost:8000`.

## Deploy with GitHub Pages

1. Open repository **Settings → Pages**.
2. Under **Build and deployment**, choose **GitHub Actions**.
3. Wait for the Pages workflow to finish.
4. Open https://hitomi101kami.github.io/project-sekai-3d-mv-player/

## Project SEKAI resource-folder workflow

Choose the parent character-resource folder containing the separate Head, Body and Accessory directories. The browser scans the selected files in-place and indexes FBX files and common image textures while retaining relative paths for texture lookup. Files are not uploaded by this local file-picker workflow.

The first folder-import milestone is an asset inventory and individual FBX preview. It classifies likely Head/Face, Body/Costume and Accessory files from folder/file names; classification is heuristic and should be checked against the actual extracted layout. Select an FBX from the discovered list to preview its mesh, skinning and embedded animation clips.

**Important current limitation:** folder scanning does not yet reconstruct a complete character by joining Head, Body and Accessory, resolve Unity serialized assets/materials, map CRC32 BlendShape names, or retarget mismatched skeletons. Those require the dedicated resource parser and character assembly pipeline. The folder picker is an initial inspection tool, not a completed Project SEKAI asset importer.

## Supported file handling

The browser preview uses FBXLoader for standard exported FBX files. It attempts to resolve common external image textures by filename/path. Proprietary Unity AssetBundles or serialized Unity files are not parsed directly.

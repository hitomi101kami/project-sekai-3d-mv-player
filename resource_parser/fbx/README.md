# FBX Parser Module

Reserved for FBX inspection and normalization.

Planned stages:
1. Identify FBX version and encoding.
2. Read nodes, meshes, materials, textures and animation stacks.
3. Preserve skin weights and bone hierarchy.
4. Normalize coordinate system, units and transforms.
5. Export a GLB plus manifest.
6. Produce a conversion report for unsupported features.

Do not assume Head, Body and Accessory FBX files share an identical skeleton or naming convention. Validate against multiple representative fixtures before implementing automatic assembly.

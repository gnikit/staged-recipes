import os
from pathlib import Path


old = b"$RPATH/wgpu_native.dll"
short = b"wgpu_native.dll"
new = short + bytes(len(old) - len(short))

patched = 0
for path in Path(os.environ["SP_DIR"]).glob("gpytoolbox_bindings*.pyd"):
    data = path.read_bytes()
    if old in data:
        path.write_bytes(data.replace(old, new))
        patched += 1

if patched == 0:
    raise SystemExit("did not find $RPATH/wgpu_native.dll in gpytoolbox bindings")

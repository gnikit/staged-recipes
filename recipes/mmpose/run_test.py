import torch

from mmpose.models import build_backbone
from mmpose.utils import register_all_modules


register_all_modules()

backbone = build_backbone(
    {"type": "ResNet", "depth": 18, "out_indices": (0, 1, 2, 3)}
)
backbone.eval()

with torch.no_grad():
    outputs = backbone(torch.ones(1, 3, 32, 32))

expected_shapes = [
    (1, 64, 8, 8),
    (1, 128, 4, 4),
    (1, 256, 2, 2),
    (1, 512, 1, 1),
]
assert [tuple(output.shape) for output in outputs] == expected_shapes

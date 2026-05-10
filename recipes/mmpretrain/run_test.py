import torch

from mmpretrain import list_models
from mmpretrain.models import build_backbone


assert "resnet18_8xb32_in1k" in list_models("resnet18*in1k")

backbone = build_backbone({"type": "LeNet5"})
backbone.eval()

with torch.no_grad():
    features = backbone(torch.ones(1, 1, 32, 32))

assert len(features) == 1
assert tuple(features[0].shape) == (1, 120, 1, 1)

import numpy as np
import torch

from mmpretrain import list_models
from mmpretrain.structures import DataSample


assert "resnet18_8xb32_in1k" in list_models("resnet18*in1k")

sample = DataSample(metainfo={"img_shape": (32, 32), "num_classes": 4})
sample.set_gt_label(2)
sample.set_pred_score([0.1, 0.2, 0.6, 0.1])
sample.set_mask(np.ones((2, 2), dtype=np.float32))

assert sample.gt_label.item() == 2
assert torch.argmax(sample.pred_score).item() == 2
assert sample.mask.dtype == torch.float32
assert tuple(sample.mask.shape) == (2, 2)

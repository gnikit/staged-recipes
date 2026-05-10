import numpy as np
from mmengine.structures import InstanceData

from mmpose.structures import (PoseDataSample, bbox_xywh2xyxy, bbox_xyxy2cs,
                               flip_keypoints)


bbox_xywh = np.array([[10.0, 20.0, 30.0, 40.0]], dtype=np.float32)
bbox_xyxy = bbox_xywh2xyxy(bbox_xywh)
np.testing.assert_allclose(bbox_xyxy, [[10.0, 20.0, 40.0, 60.0]])

center, scale = bbox_xyxy2cs(bbox_xyxy[0])
np.testing.assert_allclose(center, [25.0, 40.0])
np.testing.assert_allclose(scale, [30.0, 40.0])

keypoints = np.array([[[1.0, 2.0], [8.0, 4.0]]], dtype=np.float32)
visible = np.ones((1, 2, 1), dtype=np.float32)
flipped, flipped_visible = flip_keypoints(
    keypoints.copy(),
    visible.copy(),
    image_size=(10, 10),
    flip_indices=[1, 0],
)
np.testing.assert_allclose(flipped, [[[1.0, 4.0], [8.0, 2.0]]])
np.testing.assert_allclose(flipped_visible, visible)

instances = InstanceData()
instances.bboxes = bbox_xyxy
instances.keypoints = keypoints
instances.keypoints_visible = visible

sample = PoseDataSample(
    gt_instances=instances,
    metainfo={"img_shape": (10, 10), "input_size": (10, 10)},
)
assert "img_shape" in sample
assert len(sample.gt_instances) == 1

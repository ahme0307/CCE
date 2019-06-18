# Stochastic Capsule Endoscopy Image Enhancement
## Abstract
Capsule endoscopy, which uses a wireless camera to take images of the digestive tract, is emerging as an alternative to traditional colonoscopy. The diagnostic values of these images depend on the quality of revealed underlying tissue surfaces. In this paper, we consider the problem of enhancing the visibility of detail and shadowed tissue surfaces for capsule endoscopy images. Using concentric circles at each pixel for random walks combined with stochastic sampling, the proposed method enhances the details of vessel and tissue surfaces. The framework decomposes the image into two detailed layers that contain shadowed tissue surfaces and detail features. The target pixel value is recalculated for the smooth layer using similarity of the target pixel to neighboring pixels by weighting against the total gradient variation and intensity differences. In order to evaluate the diagnostic image quality of the proposed method, we used clinical subjective evaluation with a rank order on selected KID image database and compared it to state-of-the-art enhancement methods. The result showed that the proposed method provides a better result in terms of diagnostic image quality and objective quality contrast metrics and structural similarity index.
![alt text](https://github.com/ahme0307/CCE/blob/master/readme/Picture1.png)
## Sample result
- Capsule Endoscopy images

![alt text](https://github.com/ahme0307/CCE/blob/master/readme/fig4ab.png)

- Natural images
![alt text](https://github.com/ahme0307/CCE/blob/master/readme/Capture.PNG)

## How to run

Use the mex command to build the MEX file.

>mex RanWalker.c

The sample input images are in "Input_images" folder


To run 

>RunDemo.m


Capsule video endoscopy images

## Reference
>Mohammed, Ahmed, Ivar Farup, Marius Pedersen, Øistein Hovde, and Sule Yildirim Yayilgan. "Stochastic capsule endoscopy image enhancement." Journal of Imaging 4, no. 6 (2018): 75.


@article{mohammed2018stochastic,
  title={Stochastic capsule endoscopy image enhancement},
  author={Mohammed, Ahmed and Farup, Ivar and Pedersen, Marius and Hovde, {\O}istein and Yildirim Yayilgan, Sule},
  journal={Journal of Imaging},
  volume={4},
  number={6},
  pages={75},
  year={2018},
  publisher={Multidisciplinary Digital Publishing Institute}
}

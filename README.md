# Real-time Photometric Stereo with Computer Screen Lighting

## University of Michigan, Department of Electrical Engineering and Computer Science

This is a project I did for Professor Laura Balzano. The project was inspired by a [paper](http://www.cc.gatech.edu/~phlosoft/files/schindler08_3dpvt.pdf) published the Georgia Institue of Technology that perform real-time photometric stereo using a computer screen as its lighting source.

### Software and Hardware Requirements
1. MATLAB 2015a (or higher, should work fine with 2013 and 2014)
2. Image Acquisition Toolbox
3. Webcam (either on laptop or separate)
4. External monitor

### MATLAB Setup and Installation
1. First make sure you have MATLAB installed on your computer with the Image Acqusition Toolbox
2. Next make sure have the DCAM drivers installed. DCAM drivers can be installed via "Add-Ons" -> "Get Hardware Support Packages" -> "Install from Internet" -> "DCAM Hardware"
3. Download all the files in this Git repo and run the following in lines the MATLAB command line.

```bash
figure(2)
```
This opens up a figure for displaying the reconstruction. Once this opens, move the figure to the external monitor. Now we can begin the demo by running,
```bash
demo
```

### Overview of Implementation
WORK IN PROGRESS

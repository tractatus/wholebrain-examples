## Get probe tracts

Open up `probe_tracts.Rproj` form Rstudio.

Then open `probe_tracts.R`.

### Load wholebrain

```R
#Load wholebrain
library(wholebrain)
```

### Set segmentation filters.

```R
red.filter<-structure(list(alim = c(6, 10000), threshold.range = c(80, 255), eccentricity = 1000L, Max = 225, Min = 0, brain.threshold = 255, 
                         resize = 0.034, blur = 4L, downsample = 2), .Names = c("alim", 
                                                                                "threshold.range", "eccentricity", "Max", "Min", "brain.threshold", 
                                                                                "resize", "blur", "downsample"))

green.filter<-structure(list(alim = c(500, 10000), threshold.range = c(110, 255), eccentricity = 1000L, Max = 225, Min = 0, brain.threshold = 255, 
                          resize = 0.034, blur = 4L, downsample = 2), .Names = c("alim", 
                                                                                 "threshold.range", "eccentricity", "Max", "Min", "brain.threshold", 
                                                                                 "resize", "blur", "downsample"))


brain.filter<-structure(list(alim = c(500, 10000), threshold.range = c(2000L, 
                                                                       65000L), eccentricity = 1000L, Max = 225, Min = 0, brain.threshold = 65, 
                             resize = 0.3, blur = 12, downsample = 2), .Names = c("alim", 
                                                                                  "threshold.range", "eccentricity", "Max", "Min", "brain.threshold", 
                                                                                  "resize", "blur", "downsample"))

```

### Segment contours and perform registration

```R
myimage<-'/Users/danielfurth/Desktop/injection.tif'
red<- segment(myimage, channel = 1, filter = myfilter, get.contour = TRUE)
green<- segment(myimage, channel = 2, filter = myfilter, get.contour = TRUE)
brain<- segment(myimage, channel = 3, filter = brain.filter)

#registration
regi<-registration(myimage, coordinate = -2, channel = 3, filter = brain.filter)

```

### Create probe path dataset and sites

```R
red.points<- get.cell.ids(regi, red, forward.warp = TRUE)
green.points<- get.cell.ids(regi, green, forward.warp = TRUE)

red.points$type <- 'red'
green.points$type <- 'green3'
dataset<-rbind(red.points, green.points)

sites<-get.probe.paths(dataset, paste(dataset$type, dataset$right.hemisphere))
```

### Plot schematic with probe paths

```R
schematic.plot(dataset)
lines(sites, col = rep(c('red', 'green'), each=2), coord.sys = 'stereo', length =0.1, lwd = 2)
```
<img src="repo_images/schematic.png?raw=true" width="60%" alt="Output from schematic.plot(dataset)">

_**Figure 1** Output from `schematic.plot(dataset)` with lines on `sites` probe.paths object._

### Plot probe fluorescence and paths on original image with registration

```R
plot.registration(regi, border = 'lightblue')
draw.blobs(red)
draw.blobs(green, col = rgb(0,1,0.1, alpha = 0.5), border ='green3')
lines(sites, col = rep(c('red', 'green'), each=2), coord.sys = 'pixel', length =0.1, lwd = 2)
```

<img src="repo_images/fluorescence.png?raw=true" width="80%" alt="Output from schematic.plot(dataset)">

_**Figure 2** Output from `plot.registration(regi)` with `draw.blobs(red)` and `draw.blobs(green)`._

### Plot 3D brain
```R
perspective<-list(FOV = 30, 
                  ignoreExtent = FALSE, 
                  listeners = 1L, 
                  mouseMode = structure(c("trackball", "zoom", "fov", "pull"
                  ), .Names = c("left", "right", "middle", "wheel")), 
                  skipRedraw = FALSE, 
                  userMatrix = structure(c(0.620774269104004, 0.410500437021255, 
                                           -0.667928755283356, 0, -0.0296718962490559, -0.839048981666565, 
                                           -0.543246030807495, 0, -0.783427774906158, 0.357052087783813, 
                                           -0.508679509162903, 0, 0, 0, 0, 1), 
                                         .Dim = c(4L, 4L)), scale = c(1,  1, 1), 
                  viewport = structure(c(0L, 0L, 1280L, 720L), .Names = c("x", "y", "width", "height")), 
                  zoom = 1, windowRect = c(0L, 45L,  1280L, 765L), 
                  family = "sans", font = 1L, cex = 1, useFreeType = TRUE)
                                                                                 
glassbrain(dataset, col = dataset$type, cex = 3, spheres = TRUE, device=TRUE, high.res = TRUE)
par3d(perspective)
tracts3d(sites, color = rep(c('red', 'green'), each=4), lwd = 3)
```

<img src="repo_images/3Dbrain.png?raw=true" width="80%" alt="Output from schematic.plot(dataset)">
_**Figure 3** Output from `glassbrain(dataset)` with `tracts3d(sites)` ._


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

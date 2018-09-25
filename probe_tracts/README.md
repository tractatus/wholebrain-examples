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

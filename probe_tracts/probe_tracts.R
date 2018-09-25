library(wholebrain)

myfilter<-structure(list(alim = c(6, 10000), threshold.range = c(80, 255), eccentricity = 1000L, Max = 225, Min = 0, brain.threshold = 255, 
                         resize = 0.034, blur = 4L, downsample = 2), .Names = c("alim", 
                                                                                "threshold.range", "eccentricity", "Max", "Min", "brain.threshold", 
                                                                                "resize", "blur", "downsample"))

myfilter2<-structure(list(alim = c(500, 10000), threshold.range = c(110, 255), eccentricity = 1000L, Max = 225, Min = 0, brain.threshold = 255, 
                          resize = 0.034, blur = 4L, downsample = 2), .Names = c("alim", 
                                                                                 "threshold.range", "eccentricity", "Max", "Min", "brain.threshold", 
                                                                                 "resize", "blur", "downsample"))


brain.filter<-structure(list(alim = c(500, 10000), threshold.range = c(2000L, 
                                                                       65000L), eccentricity = 1000L, Max = 225, Min = 0, brain.threshold = 65, 
                             resize = 0.3, blur = 12, downsample = 2), .Names = c("alim", 
                                                                                  "threshold.range", "eccentricity", "Max", "Min", "brain.threshold", 
                                                                                  "resize", "blur", "downsample"))

myimage<-'/Users/danielfurth/Desktop/injection.tif'
red<- segment(myimage, channel = 1, filter = myfilter, get.contour = TRUE)
green<- segment(myimage, channel = 2, filter = myfilter, get.contour = TRUE)
brain<- segment(myimage, channel = 3, filter = brain.filter)


regi<-registration(myimage, coordinate = -2, channel = 3, filter = brain.filter)

red.points<- get.cell.ids(regi, red, forward.warp = TRUE)
green.points<- get.cell.ids(regi, green, forward.warp = TRUE)

red.points$type <- 'red'
green.points$type <- 'green3'
dataset<-rbind(red.points, green.points)

sites<-get.probe.paths(dataset, paste(dataset$type, dataset$right.hemisphere))

schematic.plot(dataset)
lines(sites, col = rep(c('red', 'green'), each=2), coord.sys = 'stereo', length =0.1, lwd = 2)


plot.registration(regi, border = 'lightblue')
draw.blobs(red)
draw.blobs(green, col = rgb(0,1,0.1, alpha = 0.5), border ='green3')
lines(sites, col = rep(c('red', 'green'), each=2), coord.sys = 'pixel', length =0.1, lwd = 2)

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

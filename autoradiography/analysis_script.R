library(wholebrain)


myfilter<-structure(list(alim = c(0, 118), #area limits of soma size
                         threshold.range = c(7431L, 31416L), #this is the threshold range to look for speckles
                         eccentricity = 1000L,#eccentricity allowed 1000 max
                         Max = 13512, #display range Maximum value for 8-bit rendered
                         Min = 0, #display range Minimum value for 8-bit rendered
                         brain.threshold = 2364L, #threshold to find brain contour
                         resize = 0.04, #resize parameter to match atlas size to pixel size
                         blur = 6L, #blur of brain outline
                         downsample = 0.25), #donwample factor to increase processing speed
                    .Names = c("alim", "threshold.range", "eccentricity", "Max", "Min", "brain.threshold",
                                                         "resize", "blur", "downsample"))

#image file to analyze
images<-get.images('./images')

#segment speckles press ESC to continue
seg<-segment(images, filter=myfilter)

#registration
coord<-0.5 #mm from bregma AP
regi<-registration(images, filter=myfilter, coordinate=0.5)

#get final spreadsheet
dataset<-inspect.registration(regi, seg, forward.warps = TRUE)

#save all info so we can reproduce it.
save(images, seg, regi, dataset, file='radioactivity.RData')

#plot 3D brain
glassbrain(dataset)

#make schematic plot
schematic.plot(dataset)

#get regions sorted according to intensity
mean.intensity<-tapply(dataset$intensity, dataset$acronym, mean)
#sort them
mean.intensity<-sort(mean.intensity, decreasing= TRUE)
#print a table with acronym and name
outputdata<-data.frame(parent.name = name.from.acronym(get.acronym.parent(names(mean.intensity))), parent.acronym =  get.acronym.parent(names(mean.intensity)), name = name.from.acronym(names(mean.intensity)), acronym = names(mean.intensity), intensity = mean.intensity)
#write to spreadsheet file
write.csv(outputdata, file = "radioactivity_sorted_by_region.csv", row.names=FALSE)

#make a webmap into current project folder
pixel.resolution<-1 #1 micron
makewebmap(img = images, filter = myfilter, registration = regi, dataset = dataset, 
           scale = 0.64, fluorophore = "Radioactivity")
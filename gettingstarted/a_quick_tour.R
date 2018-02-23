#load the package
library(wholebrain)

#system path for folder where images can be found
folder<-'images'

#get only image files with full paths in the folder (this is used as input for registration and segmentation)
images <-get.images(folder, type = 'tiff')

#this is the filter we used it is a list object with the following parameters.
myfilter<-list(alim = c(5, 80), #area limits for what to consider as cell bodies c(minimum, maximum)
               threshold.range = c(5179, 50559), #threshold range in the minimum and maximum in fluorescent intensity where the algorithm should search for neurons.
               eccentricity = 1000, #eccentricity (elongation) of contours sets how round you want cell bodies to be. Default is 1000 and smaller values equal to more round.
               Max = 7206, #Maximum value to display in the 8-bit rendered (sets sort of brightness contrast)
               Min = 0, #Minimum value to display in the 8-bit rendered (sets sort of brightness contrast)
               brain.threshold = 1238, #the exact value where you want to start segmeting the brain outline in autofluorescence.
               resize = 0.16, #resize parameter to match the atlas to your pixel resolution, should be between 0.03 and 0.2 for most applications.
               blur = 7, #blur parameter that sets the smoothness of the tissue outline, if magaded or jagged edges increase. Using a value fo 4 is usually recommended.
               downsample = 1 #downsample, default is set to 0.25 and images with a size of 15000 x 8000 pixels can then usually be run smoothly
               )

#segmentation
seg <- segment(images[1], filter = myfilter, display = TRUE)

#to get the filter from a segmentation list into code.
edit(seg$filter)

#opens a new plot window which we will use for registration output.
quartz()
#registration
regi <- registration(images[1], filter = myfilter, coordinate = -1.2, plane = 'coronal' )

#change some specific points
regi <- change.corrpoints(regi, c(32:31, 1))
#add points (right click to close command when done with adding points)
regi<-add.corrpoints(regi)
#remove these points entirely
regi<-remove.corrpoints(regi, c(37))

#correspondance points can be seen in a data.frame
regi$correspondance

#update the registration by runnig registration command BUT adding correspondance = regi to use the correspondance points.
regi <- registration(images[1], filter = myfilter, coordinate = -1.2, correspondance = regi )

#new ploting window
quartz()
#get the cells into a neat and tidy spread sheet like data.frame
dataset<-inspect.registration(registration = regi, segmentation = seg, forward.warps = TRUE)

#look at the first 6 rows ont he dataset to get a feeling of the variables
head(dataset)

#plot a dot.plot
dot.plot(dataset)

#show cell counts by region and sort them.
cell.count <- table(dataset$acronym)
cell.count <- sort(cell.count)
cell.count

#show cell counts by region times hemisphere.
laterality <- table(dataset$acronym, dataset$right.hemisphere)
laterality

#plot a schematic
schematic.plot(dataset)

#save as Excel spread.sheet
write.table(dataset, file='mybraindata.csv', sep=',', row.names =FALSE)

#make a web-based map
pixel.resolution.in.microns <- 2
makewebmap(images[1], filter = myfilter, registration = regi, dataset = dataset, folder.name = NULL, scale = pixel.resolution.in.microns)

#plot a 3D brain
#open up 3D rbain plot
glassbrain(dataset)
#move around the rbian to a position you like. (you can save the position for later by using position <- par3d() )

#to make a high resolution rendering set high.res flag to TRUE and then set device = FALSE so we do not open a new window but use the old one.
glassbrain(dataset, high.res =TRUE, device =FALSE)
#save the 3D plot into a PNG file
rgl.snapshot('mybrain.png')

#save everything you need for reproducing the things you just did.
save(images, seg, regi, dataset, file='mydata.RData')

#to load this data simply use:
load('mydata.RData')







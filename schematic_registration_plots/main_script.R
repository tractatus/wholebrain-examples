#Load dataset and regi (THIS WILL OVERWRITE ANY EXISTING regi OR dataset NAMED OBJECTS)
load(file='regi_dataset.RData')

#tryout the plot.registration() function
plot.registration(regi)
#change outline colors to orange and also draw transformaition grid in purple
par(bg='black')
plot.registration(regi, border = 'orange', draw.trans.grid = TRUE, grid.color = 'purple')


#plot the outlines in tissue space
plot.outlines(regi, plot = TRUE)
#add the neurons
points(dataset$x, dataset$y, pch = 16, col = dataset$color)

#make a pplot where we use the intensity of each cell to make heat color ramp on log2 scale
color<-heat.colors(100)[as.numeric(cut(log2(dataset$intensity), breaks = 100))]
plot.outlines(regi, plot = TRUE)
points(dataset$x, dataset$y, pch = 16, col = color)

#tryout the schematic plot function
schematic.plot(dataset)
#make schematic plot without, title, without millimeter grid and with a 1 mm scale bar.
schematic.plot(dataset, title = FALSE, mm.grid = FALSE, scale.bar = TRUE)



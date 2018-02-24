## Schematic plots and outline plots

Open up `schematic_registration_plots.Rproj` form Rstudio.

Then open `main_script.R`.

### Load the data provided in this project.

```R
#Load dataset and regi (THIS WILL OVERWRITE ANY EXISTING regi OR dataset NAMED OBJECTS)
load(file='regi_dataset.RData')
```

### Plot schematic steroetactic atlas plate with your data.

```R
#tryout the schematic plot function
schematic.plot(dataset)
```
<img src="repo_images/schematic_plot01.png?raw=true" width="60%" alt="Output from schematic.plot(dataset)">

_**Figure 1** Output from `schematic.plot(dataset)`._

```R
#make schematic plot without, title, without millimeter grid and with a 1 mm scale bar.
schematic.plot(dataset, title = FALSE, mm.grid = FALSE, scale.bar = TRUE)
```
<img src="repo_images/schematic_plot02.png?raw=true" width="60%" alt="Output from schematic.plot(dataset, title = FALSE, mm.grid = FALSE, scale.bar = TRUE)">

_**Figure 1** Output from `schematic.plot(dataset, title = FALSE, mm.grid = FALSE, scale.bar = TRUE)`._


### Plot registration overlay on micrograph raster image.

```R
#tryout the plot.registration() function
plot.registration(regi)
```
<img src="repo_images/plot_registration01.png?raw=true" width="60%" alt="Output from plot.registration(regi)">

_**Figure 3** Output from `plot.registration(regi)`._

We can change some input parameters to customize the output:

```R
#change outline colors to orange and also draw transformaition grid in purple
par(bg='black')
plot.registration(regi, border = 'orange', draw.trans.grid = TRUE, grid.color = 'purple')
```

<img src="repo_images/plot_registration02.png?raw=true" width="60%" alt="Output from plot.registration(regi, border = 'orange', draw.trans.grid = TRUE, grid.color = 'purple')">

_**Figure 4** Output from `plot.registration(regi, border = 'orange', draw.trans.grid = TRUE, grid.color = 'purple')`._**_

### Plot outlines of the registration from the tissue.

We can also just plot the outlines from the backward registration onto the tissue section.
Also adding the neurons form the `dataset` object on top using the `x` and `y` pixel coordinates.
```R
#plot the outlines in tissue space
plot.outlines(regi, plot = TRUE)
#add the neurons
points(dataset$x, dataset$y, pch = 16, col = dataset$color)
```
<img src="repo_images/plot_outlines01.png?raw=true" width="60%" alt="Output from `plot.outlines(regi, plot = TRUE)">

_**Figure 5** Output from `plot.outlines(regi, plot = TRUE)`._**_

Lets customize this so we can display the fluorescent intensity of each cell body by using `heat.colors()` color palette ramp.
```R
#make a plot where we use the intensity of each cell to make heat color ramp on log2 scale
color<-heat.colors(100)[as.numeric(cut(log2(dataset$intensity), breaks = 100))]
plot.outlines(regi, plot = TRUE)
points(dataset$x, dataset$y, pch = 16, col = color)
```
<img src="repo_images/plot_outlines02.png?raw=true" width="60%" alt="Output from `plot.outlines(regi, plot = TRUE)">

_**Figure 6** Output from `plot.outlines(regi, plot = TRUE) using color ramp to display neuron fluorescent intensity`._**_



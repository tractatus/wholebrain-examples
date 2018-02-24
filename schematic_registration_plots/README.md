### Schematic plots and outline plots

Open up `schematic_registration_åplots.Rproj` form Rstudio.

Then open `main_script.R`.

#### Load the data provided in this project.

```R
#Load dataset and regi (THIS WILL OVERWRITE ANY EXISTING regi OR dataset NAMED OBJECTS)
load(file='regi_dataset.RData')
```

#### Plot registration overlay on micrograph raster image.

```R
#tryout the plot.registration() function
plot.registration(regi)
```

![Output from plot.registration(regi)](repo_images/plot_outlines01.png?raw=true "plot.registration(regi)" | width=100)
**Figure 1 Output from `plot.registration(regi)`.**

We can change some input parameters to customize the output:

```R
#change outline colors to orange and also draw transformaition grid in purple
par(bg='black')
plot.registration(regi, border = 'orange', draw.trans.grid = TRUE, grid.color = 'purple')
```
# Color for Maps 
library(ggplot2)
library(reshape2)
library(dplyr)  # required for arrange()
library(colorspace)
library(viridis)
library(maps) # for the state map data
library(mapproj) ## THIS FIXES ERROR IN LECTURE

#### Contour maps ####
# Filled contour maps for ggplot2
boom<-melt(volcano)
range(boom$value) # 94, 195 Check out the range of values to pick scale breaks

boom$levels<-cut(boom$value,breaks=c(90,100,125,150,175,200)) # create breaks in values
boom$levels<-cut(boom$value,breaks=seq(90,200,by=10))

colors_surface<-terrain_hcl(nlevels(boom$levels), c = c(65, 0), l = c(45, 90), power = c(1/2, 1.5)) # Create color
#colors_surface<-sequential_hcl(nlevels(boom$levels), c = 0, l=c(30,90), power = 2.0)
colors_surface<-viridis(nlevels(boom$levels))

ggplot(boom,aes(Var1,Var2)) + xlab(" ") + ylab(" ") +
  geom_tile(aes(fill=levels)) + 
  scale_fill_manual("surface",values=colors_surface)


# required packages

states_map<-map_data("state") #extracts data from the states map

# Make a data set of US crime data from the USArrests data set
crimes<-data.frame(state=tolower(rownames(USArrests)),USArrests)
crime_map<-merge(states_map,crimes,by.x="region",by.y="state")
crime_map<-arrange(crime_map,group,order)
#head(crime_map)

# Plot make of murder rate. You can select any column in that 
basemap1<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=factor(Murder))) +
  geom_polygon() + coord_map("sinusoidal") #gilbert, mollweide, polyconic 

# Color map diverging from the midpoint (mean murder rate) with colorspace 
basemap1 + scale_fill_hue(guide = "none")

#### by hue
basemap2<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=factor(Assault))) +
#basemap2<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=hsv(h=(max(Murder)-Murder)/max(Murder)/7,s=Assault/max(Assault),v=1))) +
  geom_polygon() + coord_map("sinusoidal") #gilbert, mollweide, polyconic 
basemap2 + scale_fill_hue(guide = "none")


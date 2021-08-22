# CS-710 HW 7 Color for Maps 
# required packages
library(ggplot2)
library(reshape2)
library(dplyr)  # required for arrange()
library(colorspace)
library(viridis)
library(maps) # for the state map data
library(mapproj) # map projections

states_map<-map_data("state") #extracts data from the states map

# Make a data set of US crime data from the USArrests data set
crimes<-data.frame(state=tolower(rownames(USArrests)),USArrests)
crime_map<-merge(states_map,crimes,by.x="region",by.y="state")
crime_map<-arrange(crime_map,group,order)
#head(crime_map)
#basemap<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=hsv(h=(max(Murder)-Murder)/max(Murder),s=Assault/max(Assault),v=1))) +

# 1. Murder rate. You can select any column in that 
#basemap1<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=factor(Murder))) +
basemap1<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=hsv(h=(max(Murder)-Murder)/max(Murder),s=1,v=1))) 
basemap1 + geom_polygon() + coord_map("sinusoidal") + scale_fill_discrete_diverging(guide = "none") + ggtitle("Murder map")
#scale_fill_hue(guide = "none")
#scale_fill_identity(guide = "none")

#### 2. Assault
#basemap2<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=factor(Assault))) +
basemap2<-ggplot(crime_map,aes(x=long,y=lat,group=group,fill=hcl(h=1,c=(max(Assault)-Assault)/max(Assault),l=1))) 
basemap2 + geom_polygon() + coord_map("sinusoidal") + scale_fill_discrete_diverging(guide = "none") + ggtitle("Assault map")

# TidyTuesday "Modes Less Traveled - Bicycling and Walking to Work in the United States: 2008-2012"
# R_meetup 7th November 2019
# GET THE DATA
commute_mode <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-05/commute.csv") 

# load pakages
library(tidyverse)
library(sf) #GIS package
library(ggrepel)# makes lables and points not overlap
library(ggspatial) # allowes usage of GIS layers from sf pkg in ggplot
library(maps) # spatial data 
library(wesanderson) #color palette

#spatial data available from the "maps" package
data(us.cities)
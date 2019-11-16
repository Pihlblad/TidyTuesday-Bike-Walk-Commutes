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

# Commuter data prep
cities <- commute_mode %>% 
  separate(city, 
           into= c("city_name", "city_descriptor"),
           sep= " (?=city|village|town|borough|municipality|urban)",
           extra= "merge") %>% 
  mutate(
    name = paste(city_name, state_abb)
  ) %>% 
  left_join(us.cities, by="name") %>% 
  filter(capital ==2) # 2 = state capital

# mapping cummuter stats in US capital cities with ggplot
ggplot(cities, aes(long, lat))+
  borders("state", fill = "antiquewhite", colour = gray(0.4))+ #border polygon from the maps pkg
  geom_point(colour="black") +
  geom_label_repel(aes(fill=percent, label = name,label.size = 0.1))+
  scale_fill_gradientn(colours = wes_palette(n=20, name="GrandBudapest2",
                                             type="continuous"))+
  coord_sf(xlim = c(-125.15, -69.12), ylim = c(24.65, 50.97))+ #Lat/Long extent to be shown
  facet_grid(mode~.)+ 
  theme_bw()+ 
  theme(panel.grid.major = element_line(color = gray(.75), 
                                        linetype ="dashed", 
                                        size = 0.5), 
        panel.background = element_rect(fill = "aliceblue"))+
  labs(title="Modes Less Traveled", 
       subtitle = "% Biking and Walking to Work in State Capitals: 2008-2012",
       caption = "source: U.S. Cencus Bureau, American Community Survey, 2008-2012 & #TidyTuesday ")+
  xlab("Longitude") + 
  ylab("Latitude")
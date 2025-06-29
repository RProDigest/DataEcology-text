# ============================================================================
# Script: UK MAPS.R
# Purpose: Create Maps for UK Tech Hubs
# Author: Mubanga Nsofu
# Course: UEL-DS-7001 Data Ecology
# Student ID: R2012D11689258
# License: CC BY-NC-SA 4.0
# Institution: University of East London
# Version: 1.0
# Date: 2025-06-29
# ============================================================================



# 1.0 INSTALL PACKAGES---------------------------------

if (!require(pacman)) {
  install.packages("pacman")
}

pacman::p_load(tidyverse, 
               sf, 
               rnaturalearth, 
               rnaturalearthdata, 
               ggrepel,
               scales,
               grid,
               ggrepel,
               leafpop,
               mapview,
               htmlwidgets
)

# 2.0 LOAD UK MAP------------------------------

uk <- ne_countries(scale = "medium", returnclass = "sf") %>%
  filter(admin == "United Kingdom")

# Enhanced tech hub data with activity metrics
tech_hubs <- data.frame(
  city = c("London", "Manchester", "Birmingham", "Cambridge", "Liverpool", "Reading", "Leeds", "Basingstoke"),
  lat = c(51.5074, 53.4808, 52.4862, 52.2053, 53.4084, 51.4543, 53.8008, 51.2665),
  lon = c(-0.1278, -2.2426, -1.8904, 0.1218, -2.9916, -0.9781, -1.5491, -1.0872),
  specialization = c(
    "Accelerators, VCs, Startups",         
    "IoT, MediaCity, Hosting",              
    "Health Tech, AI, FinTech",             
    "AI, Life Sciences, Cyber Security",    
    "FinTech, AR/VR, EdTech",               
    "Big Tech HQs, Data & Analytics",       
    "Emerging FinTech & AI",                
    "High Tech Density, Telecom"
  ),
  # Tech activity score (1-10 scale) - based on your document data
  tech_activity = c(10, 7, 6, 8, 5, 9, 4, 6),
  # Tier classification
  tier = c("Primary", "Secondary", "Secondary", "Primary", "Emerging", "Primary", "Emerging", "Secondary"),
  # Add slight downward nudge for London specialization only
  spec_nudge_y = c(-0.15, 0, 0, 0, 0, 0, 0, 0)
)

# 3.0 CREATE SEPARATE DATASETS FOR BETTER CONTROL------------------

city_labels <- dplyr::select(tech_hubs, city, lat, lon, tech_activity, tier)
spec_labels <- dplyr::select(tech_hubs, specialization, lat, lon)

# Convert to sf

tech_hubs_sf <- st_as_sf(tech_hubs, coords = c("lon", "lat"), crs = 4326)

# Define colors for different tiers

tier_colors <- c("Primary" = "darkred", "Secondary" = "#1F78B4", "Emerging" = "#33A02C")

#darkred

# 4.0 CREATE THE MAP------------------

uk |> 
ggplot() +
  geom_sf(fill = "gray96", color = "gray80", size = 0.3) +
  
  # Tech hubs with size based on activity and color by tier
  geom_sf(data = tech_hubs_sf, 
          aes(size = tech_activity, color = tier, fill = tier), 
          shape = 21, stroke = 1.2, alpha = 0.8, show.legend = TRUE) +
  
  # City names with better styling
  geom_text_repel(
    data = city_labels,
    aes(x = lon, y = lat, label = city),
    size = 3.2, 
    fontface = "bold",
    color = "gray20",
    min.segment.length = 0.1,
    segment.color = "gray50",
    segment.size = 0.3,
    max.overlaps = Inf,
    force = 3,
    point.padding = 0.3,
    box.padding = 0.4,
    max.iter = 10000,
    direction = "both"
  ) +
  
  # Specializations with enhanced styling
  geom_text_repel(
    data = spec_labels,
    aes(x = lon, y = lat, label = specialization),
    size = 2.1, 
    fontface = "italic", 
    color = "#2166AC",
    min.segment.length = 0.3,
    segment.color = "#7FC97F",
    segment.size = 0.25,
    max.overlaps = Inf,
    force = 6,
    force_pull = 0.1,
    point.padding = 0.6,
    box.padding = 1.0,
    max.iter = 10000,
    direction = "both",
    seed = 456,
    nudge_y = tech_hubs$spec_nudge_y
  ) +
  
  # Enhanced coordinate limits
  coord_sf(xlim = c(-4.2, 1.8), ylim = c(50.0, 55.8)) +
  
  # Professional color scales
  scale_color_manual(
    name = "Hub Classification",
    values = tier_colors
  ) +
  scale_fill_manual(
    name = "Hub Classification",
    values = tier_colors,
    guide = "none"  # Hide fill legend to avoid duplication
  ) +
  scale_size_continuous(
    name = "Tech Activity\nScore",
    range = c(2, 8),
    breaks = c(4, 6, 8, 10),
    labels = c("Low (4)", "Medium (6)", "High (8)", "Very High (10)")
  ) +
  
  # Professional theme
  theme_void() +
  theme(
    # Legend styling
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.spacing.x = unit(1, "cm"),
    legend.title = element_text(size = 9, face = "bold", color = "gray30"),
    legend.text = element_text(size = 8, color = "gray40"),
    legend.key = element_blank(),
    legend.background = element_rect(fill = "white", color = NA),
    
    # Title and subtitle styling
    plot.title = element_text(size = 16, face = "bold", color = "gray20", hjust = 0.5),
    plot.subtitle = element_text(size = 12, color = "gray40", hjust = 0.5),
    plot.caption = element_text(size = 8, color = "gray50", hjust = 1),
    
    # Panel styling
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    panel.grid = element_blank()
  ) +
  
  # Enhanced labels
  labs(
    title = "UK Tech Hub Ecosystem: Activity and Specializations",
    subtitle = "Geographic distribution of primary, secondary, and emerging technology clusters",
    caption = "Size indicates tech activity level • Color shows hub classification\nData sources: Natural Earth, ONS, Tech City UK reports\nPlotted by M.Nsofu June 2025"
  )
# Save the plot

ggsave("UK_Tech_Hubs_Map.png", width = 10, height = 8, dpi = 900)


# 5.0 DEFINE TECH HUBS ------------------

# LONDON TECH HUBS

london_hubs <- data.frame(
  name = c(
    "Level39 (Canary Wharf)",
    "Tech City (Shoreditch)",
    "Wayra UK (Soho)",
    "Google for Startups (King's Cross)",
    "Imperial White City Incubator",
    "Queen Mary University (Mile End)",
    "Startupbootcamp (Aldgate)",
    "London South Bank University (Elephant & Castle)"
  ),
  lat = c(51.5045, 51.5246, 51.5142, 51.5335, 51.5171, 51.5252, 51.5141, 51.4967),
  lon = c(-0.0185, -0.0801, -0.1357, -0.1234, -0.2224, -0.0385, -0.0759, -0.1044),
  type = c(
    "FinTech Accelerator",
    "Startup Cluster",
    "Corporate Accelerator",
    "Startup Campus",
    "University Incubator",
    "Academic R&D",
    "Startup Accelerator",
    "Academic Incubator"
  )
)

# Convert to sf
london_hubs_sf <- st_as_sf(london_hubs, coords = c("lon", "lat"), crs = 4326)

# Plot using mapview with CartoDB Toner
mapview(
  london_hubs_sf,
  zcol = "type",
  popup = leafpop::popupTable(london_hubs_sf, zcol = c("name", "type")),
  map.types = c("Stadia.StamenToner","OpenStreetMap.DE","CartoDB.Positron"),
  legend = TRUE,
  label = london_hubs_sf$name,
  layer.name = "London Tech Hubs"
)




# MANCHESTER TECH HUBS

manchester_hubs <- data.frame(
  name = c(
    "The Sharp Project",
    "Manchester Science Park",
    "MediaCityUK",
    "Citylabs (Oxford Road Corridor)",
    "IN4.0 Group (Salford Quays)",
    "Mi-IDEA Innovation Centre",
    "Manchester Metropolitan University (AI Lab)",
    "University of Manchester Innovation Centre"
  ),
  lat = c(53.5017, 53.4624, 53.4721, 53.4665, 53.4705, 53.4693, 53.4726, 53.4729),
  lon = c(-2.2005, -2.2435, -2.3024, -2.2336, -2.2960, -2.2397, -2.2381, -2.2367),
  type = c(
    "Digital & Production Hub",
    "Innovation Campus",
    "Broadcast & IoT Cluster",
    "Life Sciences Hub",
    "Digital Accelerator",
    "Innovation & Co-working Space",
    "Academic AI Research",
    "University-linked Innovation Centre"
  )
)

# Convert to sf
manchester_hubs_sf <- st_as_sf(manchester_hubs, coords = c("lon", "lat"), crs = 4326)

# Plot using mapview
mapview(
  manchester_hubs_sf,
  zcol = "type",
  popup = leafpop::popupTable(manchester_hubs_sf, zcol = c("name", "type")),
  map.types = c("Stadia.StamenToner", "OpenStreetMap.DE", "CartoDB.Positron"),
  legend = TRUE,
  label = manchester_hubs_sf$name,
  layer.name = "Manchester Tech Hubs"
)


# 6.0 CREATE TABLE
library(reactablefmtr)

tbl <-  readxl::read_excel("ManLon.xlsx")

glimpse(tbl)

tbl |> 
  reactable(
    theme = fivethirtyeight(),
    resizable = TRUE
  )-> tbl_widget
# Save the table as an HTML file

saveWidget(tbl_widget, "UK_Tech_Hubs_Table.html", selfcontained = TRUE)

reactable::save_reactable(tbl, "UK_Tech_Hubs_Table.html")

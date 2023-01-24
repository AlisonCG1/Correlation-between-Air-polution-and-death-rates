library(shiny)
library(shinydashboard)
library(tidyverse)
library(sf)
library(ggplot2)
library(dplyr)
library(readxl)
library(hrbrthemes)
library(viridis)
library(forcats)
library(data.table)
library(scales)
library(leaflet)
library(geojsonio)
library(RColorBrewer)
library(shinythemes)
library(htmltools)
library(plotly)

world_country <- readRDS("data/world_country.rds")


global_pollution <- readRDS("data/global_pollution.rds")%>%
  mutate(Cause = str_trim(Cause))


Total_country <- world_country%>%
  filter(Cause == "Total")


labels <- paste(
  "Country: ", Total_country$COUNTRY,"<br/>",
  "Death Rates: ", Total_country$Rate, "<br/>"
)%>%
  lapply(htmltools::HTML)

labelOptions = labelOptions(
  style = list("font-weight" = "normal", padding = "3px 8px", "color" = ~PM),
  textsize = "15px", direction = "auto")

stroke <- world_country%>%
  filter(Cause == "Stroke")

s_labels <- paste(
  "Country: ", stroke$COUNTRY,"<br/>",
  "Death Rates: ", stroke$Rate, "<br/>"
)%>%
  lapply(htmltools::HTML)

heart_disease <- world_country%>%
  filter(Cause == "Ischaemic heart disease")


h_labels <- paste(
  "Country: ", heart_disease$COUNTRY,"<br/>",
  "Death Rates: ", heart_disease$Rate, "<br/>"
)%>%
  lapply(htmltools::HTML)

pulmonary_disease <- world_country%>%
  filter(Cause == "Chronic obstructive pulmonary disease")

p_labels <- paste(
  "Country: ", pulmonary_disease$COUNTRY,"<br/>",
  "Death Rates: ", pulmonary_disease$Rate, "<br/>"
)%>%
  lapply(htmltools::HTML)

lung_cancers <- world_country%>%
  filter(Cause == "Trachea, bronchus, lung cancers")

l_labels <- paste(
  "Country: ", lung_cancers$COUNTRY,"<br/>",
  "Death Rates: ", lung_cancers$Rate, "<br/>"
)%>%
  lapply(htmltools::HTML)

respiratory_infections <- world_country%>%
  filter(Cause == "Lower respiratory infections")

r_labels <- paste(
  "Country: ", respiratory_infections$COUNTRY,"<br/>",
  "Death Rates: ", respiratory_infections$Rate, "<br/>"
)%>%
  lapply(htmltools::HTML)


#Seeting colors for each death cause

country = "#cc4c02"
  c_stroke = "#662506"
    c_heart_disease = "#045a8d"
      c_pulmonary_disease = "#4d004b"
        c_lung_cancers = "#016c59"
          c_respiratory_infections = "#4d004b"
          

 pal1 <- colorNumeric("Blues", domain = NULL, na.color = "transparent")
 Total_country$death_rates_hex <- pal1(Total_country$Rate)
  


  
  
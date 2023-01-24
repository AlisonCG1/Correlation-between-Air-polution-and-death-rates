library(shiny)
library(shinydashboard)
library(shinythemes)
library(leaflet)
library(plotly)
library(ggplot2)
library(DT)



server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet(
    leaflet()%>%
      addProviderTiles(providers$CartoDB.Positron)%>%
      addLayersControl(
        position = "bottomright",
        overlayGroups = c("Total", "stroke", "heart_disease", "pulmonary_disease", "lung_cancers", "respiratory_infections"),
        options = layersControlOptions(collapsed = FALSE))%>% 
      
      
      
      addLegend("bottomright", pal = pal1, values = Total_country$Rate,
                title = "<small>Death rates per 100,000</small>")%>%
      
      
      addPolygons(
        data = Total_country,
        color = "black",
        weight = 0.8,
        fillColor = ~death_rates_hex,
        fillOpacity = 0.8,
        smoothFactor = 0.2)%>%
      
      addCircles(data = Total_country, lat = ~ latitude, lng = ~ longitude, weight = 5, radius = (~PM*100000), group = "Total_country", label = labels, fillOpacity = 0.3, labelOptions = labelOptions, color = country) %>%
      
      addCircles(data = stroke, lat = ~ latitude, lng = ~ longitude, weight = 5, radius = (~PM*100000),  group = "stroke", label = s_labels, fillOpacity = 0.3, color = ~c_stroke, labelOptions = labelOptions)%>%
      
      addCircles(data = heart_disease, lat = ~ latitude, lng = ~ longitude, weight = 5, radius = (~PM*100000), group="heart_disease", label = h_labels, fillOpacity = 0.3, color = ~c_heart_disease, labelOptions = labelOptions)%>%
      
      addCircles(data = pulmonary_disease, lat = ~ latitude, lng = ~ longitude, weight = 5, radius = (~PM*100000), group= "pulmonary_disease", label = p_labels, fillOpacity = 0.3, color = ~c_pulmonary_disease, labelOptions = labelOptions)%>%
      
      addCircles(data = lung_cancers, lat = ~ latitude, lng = ~ longitude, weight = 5, radius = (~PM*100000), group = "lung_cancers", label = l_labels, fillOpacity = 0.3, color = ~c_lung_cancers, labelOptions = labelOptions)%>%
      
      addCircles(data = respiratory_infections, lat = ~ latitude, lng = ~ longitude, weight = 5, radius = (~PM*100000), group = "respiratory_infections", label = r_labels, fillOpacity = 0.3, color = ~c_respiratory_infections, labelOptions = labelOptions)
    
 
  )
  
    
 # output$data <- renderDataTable(world_country)
  

  output$graph <- renderPlot({
    
    ggplot(data =global_pollution,
           mapping = aes(x = Rate, fill = continent)) +
      geom_histogram(alpha = 0.5, bins = 50) +
      scale_x_log10() +
      labs(x = "Death Rates", y = "Count",
           title = "Death rates per continent") +
      facet_grid(. ~ continent) +
      theme_bw()
    
  })

output$point <- renderPlot({
  
  global_pollution%>%
    filter(Cause != "Total")%>%
  ggplot(aes(x=Rate, group=Cause, fill=Cause)) +
    geom_density(adjust=.5, alpha=.5) +
    scale_x_log10()+
    theme_ipsum()
})



output$global <- renderDT(global_pollution)

output$Summ <- renderPrint(summary(global_pollution))




}



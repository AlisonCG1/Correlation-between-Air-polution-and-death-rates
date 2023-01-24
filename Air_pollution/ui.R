
library(shiny)
library(shinydashboard)
library(shinythemes)
library(tidyverse)


ui <- dashboardPage(skin = "black",
  
  dashboardHeader(title = "Death rates caused by Particulate Matter", titleWidth = 450),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Map", tabName = "Map", icon = icon("map")),
    menuItem("Plots", icon = icon("th"), tabName = "Plots")
    
    )
  ),
  dashboardBody(
    tags$head(tags$style(HTML('
    .main-header .logo {
      font-family: "Georgia", Times, "Times New Roman", serif;
      font-weight: bold;
      font-size: 24px;
    }
    '))),
    
    tabItems(
      tabItem(tabName = "Map",
              
    fluidPage(
      leafletOutput("mymap", height = 800))),
    
    # fluidRow(
    # dataTableOutput("data"))),
    
      
      tabItem(tabName = "Plots",
              fluidPage(
                plotOutput("graph",  height = 250)),
              
    fluidRow(
               box(
                tittle = "Density map Particulat matter and death rates",
                plotOutput("point", height = 250, width = 800))),
            
            box(id = "Dataset",
                    height = "1000px",
                    width = 12,
                    tabPanel("Data",
              box(DTOutput("global"), width = 12))),
              
              
    tabItem(tabName = "Summary",
            fluidPage(
              box(verbatimTextOutput("Summ"), width = 10))))
          )
  
          
            )
  )
            
    

              
    
    

    
  




  







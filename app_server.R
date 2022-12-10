library(shiny)
library(tidyverse)
library(plotly)
data <- read.csv("owid-co2-data.csv")
regions <- c("World", "Asia", "Africa", "Europe", "North America", "Oceania", "South America")
data <- data %>% select(year, country, co2) %>% filter(country %in% regions)
data <- na.omit(data)

world <- data[data$country=="World", ]
min_year <- min(data$year)
max_year <- max(data$year)
max_co2 <- max(world$co2)
max_co2_year <- world$year[which.max(world$co2)]
avg_co2 <- mean(world$co2)



server <- function(input, output) {
  output$line <- renderPlotly({
    df <- data %>% filter(year>=input$year[1],  year<=input$year[2])
    df <- df %>% filter(country==input$country)
    req(nrow(df)>0)
    ggplot(df, aes(x=year, y=co2)) + geom_line()
    
  })
  
}
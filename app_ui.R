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
ui <- navbarPage("A5: Data Applications",
                 tabPanel("Introduction",
                          h2("About data"),
                          p(" CO2 and Greenhouse Gas Emissions dataset is a collection of key metrics maintained by Our World in Data. It is updated regularly and includes data on CO2 emissions (annual, per capita, cumulative and consumption-based), other greenhouse gases, energy mix, and other relevant metrics."),
                          tags$img(src="https://www.gannett-cdn.com/-mm-/66879ba32d75a4cd24eb0fe14ecb9620fd6f9907/c=121-0-898-439/local/-/media/2016/11/04/USATODAY/USATODAY/636138555905413964-InsertImage.jpg?width=3200&height=1680&fit=crop", width="100%"),
                          h2("Summary statistic"),
                          p(paste0("The data ranges from ", min_year, " to ", max_year, ", the maximum annual total production-based emissions of carbon dioxide (CO₂) over the world is ", max_co2, " million tonnes,", 
                                   " it occurred in ", max_co2_year, ", the average annual total production-based emissions of carbon dioxide (CO₂) over the world is ", avg_co2, " million tonnes."))
                 ),
                 tabPanel("Interactive visualization",
                          sidebarLayout(
                            sidebarPanel(
                              sliderInput(inputId = "year",
                                          label = "Range of year:",
                                          min = min(data$year),
                                          max = max(data$year),
                                          sep="",
                                          step=1, 
                                          value = c(min(data$year), max(data$year))),
                              selectInput("country", "Country/Region:", 
                                          choices = unique(data$country),
                                          selected = "United States"
                              )
                              
                            ),
                            mainPanel(
                              plotlyOutput(outputId = "line"),
                              p("We can see a increasing trend of the  annual total production-based emissions of carbon dioxide (CO₂) over theses, but the emission of Europe and North America has decreased in recent years.")
                            )
                          )           
                 )
)


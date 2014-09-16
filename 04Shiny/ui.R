#ui.R 

library(shiny)
#library(ggplot2)

shinyUI(pageWithSidebar(

  headerPanel("Medicare"),
  sidebarPanel(
      selectInput("Procedures",label = "Select the State",
                  choices = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                              "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
                              "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
                              "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
                              "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
                 )
  ),
  # Show a summary of the dataset and an HTML table with the 
  # requested number of observations
  mainPanel(
    tabsetPanel(
      tabPanel("Medicare Plot", plotOutput("summary"))
    ),
    verbatimTextOutput("summary")
  )
))

library(shiny)
library(dplyr)
library(plotly)
library(tidyr)
library(lubridate)

date.update <- as.Date("2020-12-01")###Update

shinyUI(fluidPage(
	div(class="outer",
	# tags$head(includeCSS("styles.css")),
	plotlyOutput("iowa_case_ts", height="100%", width="100%"),
  
	absolutePanel(id = "control", class = "panel panel-default",
                top = 60, left = 70, width = 255, fixed=TRUE,
                draggable = TRUE, height = "auto", style = "opacity: 0.8",
    selectInput("plot_type",
      label = h5("Select type"),
      choices = c("Original Counts" = "counts", "Log Counts" = "logcounts")
    )# end of selectInput1
  )
  ) # end of div
) # end of tab
)

library(shiny)
library(dplyr)
library(plotly)
library(tidyr)
library(lubridate)

library(cdcfluview)
date.update <- as.Date("2020-12-01")###Update

shinyUI(fluidPage(
	div(class="outer",
	# tags$head(includeCSS("styles.css")),
	plotlyOutput("ili_age_ts", height="100%", width="100%"),
  
	absolutePanel(id = "control", class = "panel panel-default",
                top = 60, left = 85, width = 255, fixed=TRUE,
                draggable = TRUE, height = "auto", style = "opacity: 0.8",
    selectInput("plot_type",
      label = h5("Select type"),
      choices = c("All" = "All",
        "age_00_04" = "age_00_04", "age_05_24" = "age_05_24", "age_25_49" = "age_25_49",
                  "age_50_64" = "age_50_64", "age_65" = "age_65")
    )# end of selectInput1
  )
  ) # end of div
) # end of tab
)

shinyUI(fluidPage(
  sliderInput("date.update",
              label = h5("Select date"),
              min = as.Date("2020-11-12"),
              max = as.Date("2020-12-11"),
              value = as.Date("2020-12-11"),
              timeFormat = "%d %b",
              animate = animationOptions(interval = 2000, loop = FALSE)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotlyOutput("state_daily_bc", height = "100%", width = "150%")
  )
))
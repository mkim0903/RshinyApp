
cols <- c("#045a8d", "#cc4c02")
iowa.case.ts = function(date.update, plot.type) {
  dfplot = slid::dfplot
  if (plot.type == 'counts'){
   ts <-
     ggplot(dfplot, aes(Date, DailyCases, colour = Group) ) +
     ## Plot observed
     geom_line(colour = 'darkgray')  +
     geom_point()  +
     scale_color_manual(values = c("Observation" = cols[1], "Prediction" = cols[2])) +
     ## Change labs
     labs(title = 'Daily new infected cases and prediction for Iowa')  +  
     xlab('Date') +
     ylab('Daily new cases')
   
  }else if (plot.type == 'logcounts'){
    ts <-
      ggplot(dfplot, aes(Date, logDailyCases, colour = Group)) +
      ## Plot observed
      geom_line(colour = 'darkgray')  +
      geom_point()  +
      scale_color_manual(values = c("Observation" = cols[1], "Prediction" = cols[2])) +
      ## Change labs
      labs(title = 'Logarithm of daily new infected cases and prediction for Iowa')  +  
      xlab('Date') +
      ylab('Log (Daily new cases)')
    
  }
  return(ts)	
}


shinyServer(function(input, output) {
  output$iowa_case_ts <- renderPlotly({
    ts <- iowa.case.ts(date.update = date.update, 
                     plot.type = input$plot_type)
  })
})

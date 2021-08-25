state.daily.bc <- function(date.update){
  # load daily new case data for each state
  dat.sd = slid::dat.sd
  # order the daily new cases from large to small
  ind.sd <- order(dat.sd[,format(date.update, 'X%Y.%m.%d')], decreasing = TRUE)
  # select the top 10 states with highest daily new
  df.sd <- dat.sd[ind.sd[1:10],]
  df.sd <- df.sd %>% 
    dplyr::select(State, format(date.update, 'X%Y.%m.%d')) %>% 
    mutate(Date <- format(date.update, '%m/%d'))
  df.sd$State <- as.character(df.sd$State)
  names(df.sd) <- c('State', 'DailyCases', 'Date')
  plot.title <- paste0("New Cases on ", as.character(date.update))
  
  bc.sd <-
    ggplot(df.sd, aes(State, DailyCases)) + 
    labs(title = plot.title) +
    xlab('') +
    ylab('') +
    geom_bar(stat = 'identity', fill = "#C93312") 
  return(bc.sd) 
}

shinyServer(function(input, output) {
  output$state_daily_bc <- renderPlotly({
    ts <- state.daily.bc(input$date.update)
  })
})

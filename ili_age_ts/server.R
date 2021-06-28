
mycol <- c("#F21A00","#7294D4", "#D67236", "#78B7C5", "#D8B70A")
ili_age_ts = function(date.update, plot.type) {
  Ili.usa <- ilinet(region = "national", years = NULL)
  Ili.usa10 <- Ili.usa %>% 
    filter(year >= 2010, year<=2018)
  if (plot.type == 'All'){
    all.df <- Ili.usa10 %>% select(week_start, age_0_4,age_5_24, age_25_49, age_50_64, age_65) %>% 
      gather(key = Age, value = ILI, -week_start)
    ts <-
      ggplot(all.df, aes(week_start, ILI, colour = Age) ) +
      geom_line()  +
      #geom_point()  +      
      scale_color_manual(values = mycol) +
      labs(title = 'ILI by age group')  +  
      xlab('Date') +
      ylab('ILI')
  } else if (plot.type == 'age_00_04'){
    all.df <- Ili.usa10%>%select(week_start, ILI = age_0_4)
    ts <-
      ggplot(all.df, aes(week_start, ILI) ) +
      geom_line(colour = mycol[1])  +
      # geom_line(colour = 'darkgray')  +
      #geom_point()  +
      labs(title = 'ILI by age group')  +  
      xlab('Date') +
      ylab('ILI')
  } else if (plot.type == 'age_05_24'){
    all.df <- Ili.usa10%>%select(week_start, ILI = age_5_24)
    ts <-
      ggplot(all.df, aes(week_start, ILI) ) +
      geom_line(colour = mycol[2])  +
      #geom_point()  +
      labs(title = 'ILI by age group')  +  
      xlab('Date') +
      ylab('ILI')
  } else if (plot.type == 'age_25_49'){
    all.df <- Ili.usa10%>%select(week_start, ILI = age_25_49)
    ts <-
      ggplot(all.df, aes(week_start, ILI) ) +
      geom_line(colour = mycol[3])  +
      #geom_point()  +
      labs(title = 'ILI by age group')  +  
      xlab('Date') +
      ylab('ILI')
  } else if (plot.type == 'age_50_64'){
    all.df <- Ili.usa10%>%select(week_start, ILI = age_50_64)
    ts <-
      ggplot(all.df, aes(week_start, ILI) ) +
      geom_line(colour = mycol[4])  +
      #geom_point()  +
      labs(title = 'ILI by age group')  +  
      xlab('Date') +
      ylab('ILI')
  } else if (plot.type == 'age_65'){
    all.df <- Ili.usa10%>%select(week_start, ILI = age_65)
    ts <-
      ggplot(all.df, aes(week_start, ILI) ) +
      geom_line(colour = mycol[5])  +
      #geom_point()  +
      labs(title = 'ILI by age group')  +  
      xlab('Date') +
      ylab('ILI')
  }
  
  return(ts)	
}


shinyServer(function(input, output) {
  output$ili_age_ts <- renderPlotly({
    ts <- ili_age_ts(date.update = date.update, 
                     plot.type = input$plot_type)
  })
})

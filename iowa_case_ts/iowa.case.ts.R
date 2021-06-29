# rm(list=ls())
# library(dplyr)
# library(plotly)
# library(tidyr)
# date.update <- as.Date('2020-04-11')
# date.show <- as.Date('2020-04-11')
# plot.type <- 'counts' # c('counts','logcounts')
# us.case.ts(date.show, date.update, plot.type)

cols <- c("#045a8d", "#cc4c02")
us.case.ts = function(date.show, date.update, plot.type) {
  # load most updated data to check upper limits for plots:
  file.all <- paste0('Infected_state_', 
                     as.character(date.update,format = '%Y-%m-%d'),'_updated.tsv')
  dat.all <- read.delim(file.all, header=TRUE, sep="\t")
  counts.ul <- sum(dat.all[,2])
  
	# load case data
	file.ts <- paste0('Infected_state_', 
		as.character(date.show,format = '%Y-%m-%d'),'_updated.tsv')
	dat = read.delim(file.ts, header=TRUE, sep="\t")
	
	state.show = "United States"
	state.dat=data.frame(Date=names(dat)[-1])
	state.dat=state.dat %>% 
		separate(Date,c(NA,"Date"),"X") %>%
		mutate(Date=as.Date(Date,"%Y.%m.%d")) %>% 
		mutate(Counts=colSums(as.matrix(dat[,-1]))) %>% 
		mutate(Type=c(rep("Predicted",7),rep("Observed",ncol(dat)-8))) %>% 
		mutate(LogCounts=log(Counts+1))
	
	xaxis <- list(title = "", showline = FALSE, showticklabels = TRUE,
	              showgrid = TRUE, type='date', tickformat = '%m/%d', 
	              range = c(as.Date('2020-01-20'), date.update + 12))
	margin <- list(autoexpand = FALSE, l = 40, r = 30, b = 20, t = 40, pad = 4)
	
	if (plot.type == 'counts'){
	  yaxis <- list(title = "", range = counts.ul+100000)
	  ts <- plot_ly(state.dat) %>% 
	    add_trace(x = ~Date, y = ~signif(Counts, digits = 3), type = 'scatter', 
	              mode = 'markers', color = ~Type, colors=cols, 
	              showlegend = FALSE, visible = T) %>%
	    add_lines(x = ~Date, y = ~signif(Counts, digits = 3), color = I('darkgrey'), 
	              showlegend = FALSE, visible = T) %>%
	    add_trace(x = ~Date, y = ~signif(Counts, digits = 3), type = 'scatter', 
	              mode = 'markers', color = ~Type, colors=cols, 
	              showlegend = TRUE, visible = T)
	}else if (plot.type == 'logcounts'){
	  yaxis <- list(title = "", range = c(0,log(counts.ul+100000)))
	  ts <- plot_ly(state.dat) %>% 
	    add_trace(x = ~Date, y = ~signif(LogCounts, digits = 3), type = 'scatter', 
	              mode = 'markers', color = ~Type, colors=cols, 
	              showlegend = FALSE, visible = T) %>%
	    add_lines(x = ~Date, y = ~signif(LogCounts, digits = 3), color = I('darkgrey'), 
	              showlegend = FALSE, visible = T) %>%
	    add_trace(x = ~Date, y = ~signif(LogCounts, digits = 3), type = 'scatter', 
	              mode = 'markers', color = ~Type, colors=cols, 
	              showlegend = TRUE, visible = T)
	  
	}

	ts <- ts %>% layout(title = state.show, margin = margin,
		xaxis = xaxis, yaxis = yaxis, 
		legend = list(orientation = 'h', x = -0.1, y = -0.15, 
			autosize = F, width = 250, height = 200)
		# updatemenus = chart_types
	) 
	return(ts)	
}




richness = function(data){
  site_list = list()
  #browser()
    for (i in 1:103){
    sitedata = data%>%filter(SITE == i)
    plot_nest_df = data.frame()
    for (j in 1:16){
      plotdata = sitedata%>%filter(PLOT == j)
      tmp = vector()
       for (k in 1:5){
        nestdata = plotdata%>%filter(NEST ==k)
        tmp = c(tmp, nrow(nestdata))
        }
      plot_nest_df = rbind(plot_nest_df, tmp)
      colnames(plot_nest_df) = c("Nest1","Nest2","Nest3","Nest4","Nest5")
    }
   site_list[[i]]= plot_nest_df
  }
return(site_list)   
}
  
 


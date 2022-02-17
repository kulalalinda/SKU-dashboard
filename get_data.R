get_data<-function(date) {
  # load("//E21flsbcnschub/bcn_sc_hub/3 - Forecast/10 - Kinaxis Operating Cycle/0 - Data/Outputs/CHC/South Europe MCO/RO/Apr - 2021/RData/full_sales.RData")
  raw_sales<- full_sales %>%
    dplyr::filter(category=="HistoricalSales") %>%
    select(loc,gmid,gbu,date,volumne)
  
  
  all.gmid<- unique(raw_sales$gmid)
  hist_ts<-as.list(seq (1,length(all.gmid),1)) 
  
  
  for (i in 1:length(all.gmid)) {
    onesku <- raw_sales %>% 
      filter(gmid==all.gmid[i])
    hist_ts[[i]] <- ts(onesku$volumne,
                       start = c(year(min(onesku$date)), month(min(onesku$date))),
                       end   = c(year(date) , month(date)-1),
                       frequency = 12)

    
    names(hist_ts)=all.gmid
    hist_ts <<- hist_ts
  } 
}


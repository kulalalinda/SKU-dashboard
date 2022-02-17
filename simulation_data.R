#### HF simulation
#botton up

data.frame(group = rep(LETTERS[3:4], each = 10),
           x = runif(n = 10, min = 10, max = 15),
           y = runif(n = 10, min = 100, max = 150))
           Date_start= as.Date("2020-02-01")
Date_End=Date_start+ months(24)
Item<- c('CN9AH','CN9BJ','CN9CQ','CN9FJ','CN9GD')
store.fcst <- data.frame(SKU=rep(Item,each= 24*3*4),
  # Country=rep(c("Country")),each=24)
                         Region= rep(LETTERS[1:4],each =24*3*10),
                         City = rep(letters[20:22],each=24*4*10),
                          StartDate=rep(seq.Date(from=Date_start,to=Date_End,by="month"),3*4*10),
                                        Volume = runif(n = 10*3*4, min = 1000, max = 50000))
                                        
  store.fcst <- data.frame(Item=rep(all.gmid,each=36),StartDate=rep(seq.Date(from=dmy(end.date.test)+months(2),to=dmy(end.date.test)+months(37),by="month"),length(all.gmid)),Fcst=NA)
  
                         
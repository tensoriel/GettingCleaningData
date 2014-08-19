corr <- function(directory, threshold = 0) {
  
  datain <- data.frame()
  datain <- complete(directory, 1:332)
  print(threshold)  
 
  if (threshold > 1095) { return(numeric()) }else{
    
    subset <- datain[ (datain$nobs > threshold) == TRUE,]
    files_list <- list.files(directory, full.names=TRUE)   
    files_thrsh <- files_list[ subset$id ]
    num <- length(files_thrsh)
    
    dat <- data.frame()                       
    corrs <- 0
    
    for (i in 1:num) {   
     # i <- 2
      dat  <-  read.csv(files_thrsh[i])
      #xx <- dat[complete.cases(dat),]
      sulfate <- dat[,2]
      nitrate <- dat[,3]
      corrs[i]  <- cor(sulfate,nitrate, use ="pairwise.complete.obs") 
    }
    #print(corrs[!is.na(corrs)])
    return(corrs)
  }
}









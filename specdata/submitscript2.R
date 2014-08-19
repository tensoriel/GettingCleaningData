submitscript2 <- function(directory, id = 1:332) {
  
  files_list <- list.files(directory, full.names=TRUE)   #creates a list of files
  dat <- data.frame()                             #creates an empty data frame
  dat_comp <- data.frame() 
  n_obs <- 0
  for (i in id) {     
    # dat <- rbind(dat, read.csv(files_list[i]))
    dat  <-  read.csv(files_list[i])
    idx1 <-  which( !is.na(dat[, "sulfate"])  & !is.na(dat[, "nitrate"]))
    #idx2 <-  which(  )
    #idx <- is.element(idx1, idx2)
    dat_subset  <- dat[idx1,]  
    n_obs[i]  <- length(dat_subset[,1])
  }
  
  n_obs[n_obs == 0] <- NA
  n_obs <- n_obs[!is.na(n_obs)]
  #identifies the median of the subset 
  dat_comp <- cbind(id, n_obs)
  colnames(dat_comp) <- c("id", "nobs")
  dat_comp <- as.data.frame(dat_comp)
  return(dat_comp)
}

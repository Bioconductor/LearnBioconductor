rm(list=ls())

datafile <- system.file("extdata", "nci.data", package="LearnBioconductor")
data <- read.table(datafile)
data <- as.matrix(data)
infofile <- system.file("extdata", "nci.info", package="LearnBioconductor")
info <- read.table(infofile, skip=14)

# drop subtypes that contain only 1 sample
rem <- which(table(info)==1)
rm_ind  <- match(names(rem), info[,1])
info <- info[-rm_ind,]
data <- data[, -rm_ind]

showMethods("SummarizedExperiment")
selectMethod(SummarizedExperiment, "matrix")

NCI60 <- SummarizedExperiment(assays=list(data=data), colData=DataFrame(info))
save(NCI60, file="NCI60.Rda")

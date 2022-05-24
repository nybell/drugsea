##### ----- CLEAN METADATA FILE ----- #####

# set working directory 
setwd('~/drugsets/setcorrs_dg/')

# library
library(tidyr)
library(dplyr)

# load geneset_meta.csv
meta <- read.csv('~/drugsets/setcorrs_dg/geneset_meta.csv', na.strings=c("","NA"))

##### ----- CLEAN FILE ------ ######

# rename ATC column to atc 
colnames(meta)[9] <- 'atc'

# clean data 
meta$indication <- lapply(meta$indication, function(x) tolower(gsub("[^[:alnum:],]", "", x)))     # meta$indication
meta$moa <- lapply(meta$moa, function(x) tolower(gsub("[^[:alnum:],]", "", x)))                   # meta$moa
meta$atc <- lapply(meta$atc, function(x) (gsub("[^[:alnum:],]", "", x)))                          # meta$atc
meta$disease_area <- lapply(meta$disease_area, function(x) tolower(gsub("[^[:alnum:],]", "", x))) # meta$disease_area
meta$ENTREZ <- lapply(meta$ENTREZ, function(x) gsub("[^[:alnum:],]", "", x))                      # meta$ENTREZ
meta$target <- lapply(meta$target, function(x) gsub("[^[:alnum:],]", "", x))                      # meta$target

# get atc codes
tmp <- meta %>% separate_rows(atc, sep = ',')
tmp <- subset(tmp, is.na(atc) == FALSE & atc != "")
codesAtc <- unique(tmp$atc)
rm(tmp)

# get clinical indication codes
tmp <- meta %>% separate_rows(indication, sep = ',')
tmp <- subset(tmp, is.na(indication) == FALSE & indication != "")
codesInd <- unique(tmp$indication)
rm(tmp)

# get moa codes
tmp <- meta %>% separate_rows(moa, sep = ',')
tmp <- subset(tmp, is.na(moa) == FALSE & moa != "")
codesMoa <- unique(tmp$moa)
rm(tmp)


# split strings into vectors
meta$indication <- lapply(meta$indication, function(x) as.vector(strsplit(x, ',')[[1]]))     # meta$indication
meta$moa <- lapply(meta$moa, function(x) as.vector(strsplit(x, ',')[[1]]))                   # meta$moa
meta$atc <- lapply(meta$atc, function(x) as.vector(strsplit(x, ',')[[1]]))                   # meta$atc
meta$disease_area <- lapply(meta$disease_area, function(x) as.vector(strsplit(x, ',')[[1]])) # meta$disease_area
meta$ENTREZ <- lapply(meta$ENTREZ, function(x) as.vector(strsplit(x, ',')[[1]]))             # meta$ENTREZ
meta$target <- lapply(meta$target, function(x) as.vector(strsplit(x, ',')[[1]]))             # meta$indication

# save file
save(meta,codesAtc,codesInd,codesMoa, file='~/drugsets/DATA/metadata.rdata')






###
### ### INITIAL COMMENTS HERE ###
###
### Jesse Leigh Patsolic 
### 2018 <jpatsol1@jhu.edu>
### S.D.G 
#


require(rerf)
data(mnist)

# p is number of dimensions, d is the number of random features to evaluate, iw is image width, ih is image height, patch.min is min width of square patch to sample pixels from, and patch.max is the max width of square patch
p <- ncol(mnist$Xtrain)
d <- ceiling(sqrt(p))
iw <- sqrt(p)
ih <- iw
patch.min <- 1L
patch.max <- 5L




forest <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 1L, mat.options = list(p, d, "image-patch", iw, ih, patch.min, patch.max), seed = 1L)

predictions <- Predict(mnist$Xtest, forest, num.cores = 1L)

(error.rate <- mean(predictions != mnist$Ytest))





#   Time:
##  Working status:
### Comments:
####Soli Deo Gloria

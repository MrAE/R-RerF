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

forest2 <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 2L, mat.options = list(p, d, "image-patch", iw, ih, patch.min, patch.max), seed = 1L)

forest3 <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 3L, mat.options = list(p, d, "image-patch", iw, ih, patch.min, patch.max), seed = 1L)

forest4 <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 4L, mat.options = list(p, d, "image-patch", iw, ih, patch.min, patch.max), seed = 1L)

forest5 <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 5L, mat.options = list(p, d, "image-patch", iw, ih, patch.min, patch.max), seed = 1L)

forest10 <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 10L, mat.options = list(p, d, "image-patch", iw, ih, patch.min, patch.max), seed = 1L)

forest24 <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 24L, mat.options = list(p, d, "image-patch", iw, ih, patch.min, patch.max), seed = 1L)


predictions <- Predict(mnist$Xtest, forest, num.cores = 1L)
predictions2 <- Predict(mnist$Xtest, forest2, num.cores = 2L)
predictions3 <- Predict(mnist$Xtest, forest3, num.cores = 3L)
predictions4 <- Predict(mnist$Xtest, forest4, num.cores = 4L)
predictions5 <- Predict(mnist$Xtest, forest5, num.cores = 5L)
predictions10 <- Predict(mnist$Xtest, forest10, num.cores = 10L)
predictions24 <- Predict(mnist$Xtest, forest24, num.cores = 24L)


(error.rate <- mean(predictions != mnist$Ytest))
(error.rate2 <- mean(predictions2 != mnist$Ytest))
(error.rate3 <- mean(predictions3 != mnist$Ytest))
(error.rate4 <- mean(predictions4 != mnist$Ytest))
(error.rate5 <- mean(predictions5 != mnist$Ytest))
(error.rate10 <- mean(predictions10 != mnist$Ytest))
(error.rate24 <- mean(predictions24 != mnist$Ytest))






#   Time:
##  Working status:
### Comments:
####Soli Deo Gloria

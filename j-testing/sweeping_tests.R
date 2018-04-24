###
### ### INITIAL COMMENTS HERE ###
###
### Jesse Leigh Patsolic 
### 2018 <jpatsol1@jhu.edu>
### S.D.G 
#


require(rerf)
install.packages('doMC')
require(doMC)
registerDoMC(4)
#data(mnist)
mnist <- readRDS('../R/mnist.Rdat')

# p is number of dimensions, d is the number of random features to
# evaluate, iw is image width, ih is image height, patch.min is min
# width of square patch to sample pixels from, and patch.max is the max
# width of square patch
p <- ncol(mnist$Xtrain)
d <- ceiling(sqrt(p))
iw <- sqrt(p)
ih <- iw
patch.min <- 1L
patch.max <- 5L
pmin.max <- expand.grid(1:4, 2:5)

opt.rf <- lapply(1:28, function(d) list(p, d, "rf"))
opt.poisson <- lapply(1:10, function(lam) list(p, d, "poisson", lambda = lam))
opt.image.patch <- lapply(1:nrow(pmin.max), function(i) { list(p, d, "image-patch", iw, ih, patch.min = pmin.max[i, 1], patch.max = pmin.max[i, 2]) })

opt.list <- c(opt.rf, opt.poisson, opt.image.patch)

run1 <- foreach(oi = opt.list) %dopar% {
  forest <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 1L, mat.options = oi, seed = 1L)
  predictions <- Predict(mnist$Xtest, forest, num.cores = 1L)
  error.rate <- mean(predictions != mnist$Ytest)
  list(forest = forest, pred = predictions, error = error.rate)
}

saveRDS(run1, file = "run1.Rdat")



#   Time:
##  Working status:
### Comments:
####Soli Deo Gloria

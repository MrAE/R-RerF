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
data(mnist)
#mnist <- readRDS('../R/mnist.Rdat')

# p is number of dimensions, d is the number of random features to
# evaluate, iw is image width, ih is image height, patch.min is min
# width of square patch to sample pixels from, and patch.max is the max
# width of square patch
p <- ncol(mnist$Xtrain)
d <- ceiling(sqrt(p))
iw <- sqrt(p)
ih <- iw
sq <- 2L:9L
p.min <- 2L:5L
p.max <- 2L:5L

tmp <- expand.grid(1L:8L, 2L:8L)
rectMM <- tmp[tmp$Var1 < tmp$Var2,]

opt.rf <- lapply(1:28, function(d) list(p, d, "rf"))
opt.poisson <- lapply(seq(0,5/p, length = 5)[-1], function(lam) list(p, d, "poisson", lambda = lam))

opt.image.squares <- lapply(1:length(sq), 
			  function(i) { 
				       list(p, d, "image-patch", 
					    iw, ih, 
					    patch.min = sq[i], 
					    patch.max = sq[i]) })

opt.image.rect <- lapply(1:nrow(rectMM), 
			  function(i) { 
				       list(p, d, "image-patch", 
					    iw, ih, 
					    patch.min = rectMM[i,1], 
					    patch.max = rectMM[i,2]) })

opt.list <- c(opt.rf, opt.poisson, opt.image.squares, opt.image.rect)
length(opt.list)

run1 <- foreach(oi = opt.list) %dopar% {
  forest <- RerF(mnist$Xtrain, mnist$Ytrain, num.cores = 1L, mat.options = oi, seed = 1L)
  predictions <- Predict(mnist$Xtest, forest, num.cores = 1L)
  error.rate <- mean(predictions != mnist$Ytest)
  list(forest = forest, pred = predictions, error = error.rate)
}

tmp <- sapply(run1, '[[', 3)
typ <- as.factor(sapply(opt.list, '[[', 3))
df1 <- data.frame(x = c(1:length(opt.rf),1:length(opt.poisson),1:length(opt.image.patch)),y = tmp, typ = typ)

require(ggplot2)
pdf("errors_with_types2.pdf")
show(ggplot(data = df1, aes(x = x, y = y, color = typ)) + geom_point())
dev.off()

pdf("tmp.pdf")
plot(tmp, type = 'l')
dev.off()


saveRDS(run1, file = "run1.Rdat")



#   Time:
##  Working status:
### Comments:
####Soli Deo Gloria

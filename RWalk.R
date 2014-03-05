# RWalk.R
# Generates and plots random walks
# Kipp Johnson

rm(list = ls());

### Walk Parameters ###
nWalks <- 100 # Number of Walks
walkMean <- 0 # E(x)
walkSD <- 1   # Standard deviation
walkLength <- 498 # Number of Steps
				  # Use 498 for Google Correlate
				  # Only plots first 100 steps; change manually

walkMatrix <- matrix(nrow = nWalks, ncol = walkLength)

for(j in 1:nWalks){
	
walkStore = rep(NA, walkLength);

	for( i in 2:length(walkStore)){
		walkStore[1] <- 0;
		walkStore[i] <- walkStore[i-1] + rnorm(n = 1, mean = walkMean, sd = walkSD)
	}	

	for(k in 1:length(walkStore)){
		walkMatrix[j,k] = walkStore[k]
	}

}

par(mfrow=c(2,1))
plot(0:100, seq(-30,30,by=0.6), type="n",ylab="Walk",xlab="Time Step")

for(l in 1:nWalks){
	lines(walkMatrix[l,],col= l , lwd = 0.5)
}

meanStore = rep(NA, nWalks)

for(m in 1:nWalks){
	meanStore[m] <- mean(walkMatrix[m,])
	}

hist(meanStore,main="Means of Random Walks") # t-distribution

# To input single trajectory in Google Correlate, uncomment below
# write.table(walkStore, file="time_series.txt",quote=FALSE,sep="\t")

# Combo_saltbr

setwd("~/Desktop/Poster/namd_saltbridge/2LMN-40-calc/")

infile = read.table("values.txt",header=F)

head(infile)
tail(infile)

a_row_mean <- numeric()

for( i in 1:4634){
  
  row_values <- numeric()
  
  for( j in 2:14){
    
    if(infile[i,j] < 3.2){
      row_values[j - 1] <- 1
      a_row_mean[i] <- sum(row_values,na.rm=TRUE)}
    
  }
}

plot(a_row_mean,type="l",xlab="Frame",ylab="Average K23-D28 Salt-Bond Distance")

#head(row_mean)
#infile[1,2:14]

mean(a_row_mean) # 7.233

##################################

setwd("~/Desktop/Poster/namd_saltbridge/2LMN-40-dE220calc//")

infile = read.table("values.txt",header=F)

head(infile)
tail(infile)

nj_row_mean <- numeric()

for( i in 1:4766){
  
  row_values <- numeric()
  
  for( j in 2:18){
    
    if(infile[i,j] < 3.2){
      row_values[j - 1] <- 1 
      nj_row_mean[i] <- sum(row_values,na.rm=TRUE)}
    
  }
}

plot(nj_row_mean,type="l",xlab="Frame",ylab="Average K23-D28 Salt-Bond Distance")

#head(row_mean)
#infile[1,2:14]
mean(nj_row_mean) # 7.677


setwd("~/Desktop/Poster/namd_saltbridge/2LMP-40-calc//")

infile = read.table("values.txt",header=F)

head(infile)
tail(infile)

p_row_mean <- numeric()

for( i in 1:3665){
  
  row_values <- numeric()
  
  for( j in 2:12){
    
    if(infile[i,j] < 3.2){
      row_values[j - 1] <- 1 
      p_row_mean[i] <- sum(row_values,na.rm=TRUE)}
    
  }
}

plot(p_row_mean,type="l",xlab="Frame",ylab="Average K23-D28 Salt-Bond Distance")

#head(row_mean)
#infile[1,2:14]
mean(p_row_mean) # 8.02
########################################

aseq = seq(from = 0.1, to =463.4, by = 0.1)
njseq = seq(from = 0.1, to =476.6, by = 0.1)
pseq = seq(from = 0.1, to =366.5, by = 0.1)

plot(aseq,a_row_mean, col="BLACK",xlab="Time (ns)",ylab="Number of K23-D28 Salt-Bonds",type="l",ylim=c(0,10),pch=18)
lines(pseq, p_row_mean*(2/3), col="RED")
lines(njseq, nj_row_mean, col="BLUE")
legend(x=0,y=10.3, legend=c("2LMN", "2LMN-∆E22", "2LMP"),fill=c("BLACK","BLUE","RED"),border="BLACK",bty="n")

mean(a_row_mean,na.rm=TRUE)
mean(p_row_mean,na.rm=TRUE)
mean(nj_row_mean,na.rm=TRUE)

sd(a_row_mean,na.rm=TRUE)
sd(p_row_mean,na.rm=TRUE)
sd(nj_row_mean,na.rm=TRUE)


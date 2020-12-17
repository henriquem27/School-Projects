n=120

pvals_inter <- rep(0,1e4)
coefs_inter <- rep(0,1e4)
for(i in 1:length(pvals_inter)){
given <-(runif(n,min=5,max=20))
poem <- sample(c(0,1), replace = T, size=n)
bet <- given*0.3 + poem*0.2+ poem*given*0.3 + rnorm(n,mean=0,sd=2)
model <- lm(bet~given*poem)
pvals_inter[i] <- summary(model)$coefficients[4,4]
coefs_inter[i] <-summary(model)$coefficients[4,1]
}
sum(pvals_inter <0.05)/length(pvals_inter)


cbind(pvals_inter,coefs_inter)[1:10,]

hist(coefs_inter)
hist((coefs_inter)[pvals_inter <0.05])

summary((coefs_inter)[pvals_inter <0.05])

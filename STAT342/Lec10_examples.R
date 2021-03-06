### R code from vignette source 'Lec10_examples.Rnw'

###################################################
### code chunk number 1: settings
###################################################
options(prompt = "R> ", continue = "+  ", width = 70)


###################################################
### code chunk number 2: load_packages
###################################################
# Package loading
library(readr)
library(multcompView)
library(stringr)
library(knitr)
library(gridExtra)
library(ggplot2)
library(dplyr)
library(broom)
library(tidyr)
data_dir = "~/Google Drive/Teaching-CourseDocuments/342-Spring2020/Data/"


###################################################
### code chunk number 3: rice_data
###################################################
#load the rice data and do some EDA
fname <- paste0(data_dir, "ricedata.csv")
ricedata <- read_csv(fname)
# fit ANOVA model
# we need R to know that "treatment" is a factor (category), not a number
ricedata$treatment <- as.factor(ricedata$treatment)
#using lm
lmOut <- lm(weight ~ treatment, data = ricedata)  


###################################################
### code chunk number 4: ConfInts_by_group
###################################################
#mean estimates for each group  (one way to get them, there are others)
y1bar <- lmOut$fitted.values[1]
y2bar <- lmOut$fitted.values[6]
y3bar <- lmOut$fitted.values[11]
y4bar <- lmOut$fitted.values[16]
#one-at-a-time confidence interevals
#get the mean sq error
mse <- anova(lmOut)[2,3]  #.0039
#get the t-critical value (t table value)
tcrit <- qt(.975, df = 20-4)
#create the CI: point estimate +/- margin of error
ci1 <- y1bar + c(-1,1)*tcrit*sqrt(mse/5)
ci2 <- y2bar + c(-1,1)*tcrit*sqrt(mse/5)
ci3 <- y3bar + c(-1,1)*tcrit*sqrt(mse/5)
ci4 <- y4bar + c(-1,1)*tcrit*sqrt(mse/5)
#print the confidence intervals
cbind(1:4, round(rbind(ci1, ci2, ci3, ci4),2) )

#There are many useful functions in the "emmeans" package
library(emmeans)
# lsmeans --> "least squares means"
lsmeans(lmOut, specs = "treatment")
#plot
plot(lsmeans(lmOut, specs = "treatment"), horizontal = F)
#what about confint function used in STAT 341?
confint(lmOut)      #what are these CI's of?  different than lsmeans!
lmOut$coefficients  #corresponds to coefficients--same as in STAT 341
tidy(lmOut)      #reports SE's with "beta's", not for "mu's"


###################################################
### code chunk number 5: ConfInts_by_group_Bonf_adjusted
###################################################
#Bonferroni correction: create confidence intervals
#adjusting for multiple inference: 4 confidence intervals
# (one CI for each treatment group)
tcrit_b <- qt(1 - .05/(2*4), df = 16)
tcrit_b  #2.813, quite a bit bigger than 2
tcrit
#notice that the Bonferroni-adjusted CIs are wider than the
#original (un-adjusted) CIs
ci1 <- y1bar + c(-1,1)*tcrit_b*sqrt(mse/5)
ci2 <- y2bar + c(-1,1)*tcrit_b*sqrt(mse/5)
ci3 <- y3bar + c(-1,1)*tcrit_b*sqrt(mse/5)
ci4 <- y4bar + c(-1,1)*tcrit_b*sqrt(mse/5)
cbind(1:4, round(rbind(ci1, ci2, ci3, ci4),2) )
#This process is automated in the lsmeans package
lsMeansOut <- lsmeans(lmOut, specs = "treatment")
confint(lsMeansOut, adjust = "bon")
#note: ^^ DO NOT USE THE INDIVIDUAL CIs TO COMPARE GROUPS


###################################################
### code chunk number 6: FisherLSD
###################################################
#doing individual pairwise tests
#Compare treatment 1 vs 2
TcritVal <- qt(.975, 20-4)   #2.12
TcritVal
lsMeansOut
n <- 5
ttest <- (4.28 - 3.87)/sqrt(2*mse/n)
ttest
# notice the standard error is the same for all comparisons
SEdiff <- sqrt(2*mse/n)
SEdiff #compare to summary(lmOut)
#Compare treatment 2 vs 3
ttest <- (3.87 - 3.73)/SEdiff
ttest
pval <- 2*pt(ttest, lower.tail = F, 16)
pval
#the LSD: if the absolute difference in the sample means
# is greater than the LSD, declare the groups as signif diff
LSD <- TcritVal*sqrt(2*mse/n)  #.084
LSD
#Calculate LSD using agricolae
library(agricolae)
lsdOut <- LSD.test(lmOut, "treatment")
lsdOut$statistics
#Unajdusted pairwise comparisons using emmeans
pairs(lsMeansOut, adjust = "none")
#Generates a warning, but output is OK.
CLD(lsMeansOut, adjust = "none")


###################################################
### code chunk number 7: LSD_with_Bonferroni
###################################################
# How many pairwise comparisons? 4 groups, choose 2
choose(4, 2)
#compute the LSD_bonf "by hand"
new_alpha <-  0.05/6
TcritVal_bonf <- qt(1 - new_alpha/2, 20-4)
LSD_bonf <- TcritVal_bonf*sqrt(2*mse/n)  #.084
LSD_bonf
LSD
#The R package "agricolae" easily implements
# the Bonferroni adjustment with the "LSD.test()" function
lsdOut <- LSD.test(lmOut, "treatment", p.adj = "bonferroni")
lsdOut$statistics
#Bonferroni pairwise comparisons using emmeans
pairs(lsMeansOut, adjust = "Bonferroni")
#Generates a warning, but output is OK.
CLD(lsMeansOut, adjust = "Bonferroni")


###################################################
### code chunk number 8: TukeyHSD
###################################################
#Tukey HSD by hand
HSD <- qtukey(0.95, nmeans = 4, 20-4)*sqrt(mse/5)
HSD
#create CI by hand
(y1bar - y2bar) + c(-1, 1)*HSD
#Tukey pairwise comparisons using emmeans
#Note that Tukey adjustment is done by default
pairs(lsMeansOut)
#Generates a warning, but output is OK.
CLD(lsMeansOut)


###################################################
### code chunk number 9: Dunnett
###################################################
#Dunnett comparisons using emmeans
lsmeans(lmOut, dunnett ~ treatment)


###################################################
### code chunk number 10: contrasts
###################################################
#contrasts using emmeans
L1 <- c(1, -1/3, -1/3, -1/3)
L2 <- c(0, 1, -1, 0)
L3 <- c(0, 1, 0, -1)
contrast(lsMeansOut,
         list(Ctrl_vs_MeanAcid = L1,
              Trt2_vs_Trt3 = L2,
              Trt2_vs_Trt4 = L3))


###################################################
### code chunk number 11: orthogonal_contrasts
###################################################
## check to see if contrasts are orthogonal
#contrast 1 and 2 are orthogonal
sum(L1*L2)
#contrast 1 and 3 are not orthogonal
sum(L2*L3)


###################################################
### code chunk number 12: contrast_SumOfSquares
###################################################
#write out 3 orthogonal contrasts
c1 = c(-1, -1, 1, 1)
c2 = c(-1, 1, -1, 1)
c3 = c(1, -1, -1, 1)
#check to make sure they are orthogonal
sum(c1*c2); sum(c1*c3); sum(c2*c3)
#compute the sample mean in each goup
ybars = tapply(ricedata$weight, ricedata$treatment, FUN = mean)
#compute the contrast sum of squares for each contrast
SSc1 = (sum(c1*ybars)^2)/(sum(c1^2)/5)
SSc2 = (sum(c2*ybars)^2)/(sum(c2^2)/5)
SSc3 = (sum(c3*ybars)^2)/(sum(c3^2)/5)
SSc1; SSc2; SSc3
#notice that the contrasts sum of 
# squares add up to the SS_trt
SSc1 + SSc2 + SSc3
anova(lmOut)



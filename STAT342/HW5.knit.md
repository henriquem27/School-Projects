---
title: "HW5"
author: "Henrique Magalhaes Rio"
output:
  pdf_document: default
  word_document: default
header-includes:
- \usepackage{xcolor}
- \usepackage{framed}
---
<!-- STUDENTS: change the "title" and "author above"
DO NOT EDIT THE SECTION BELOW -->
\colorlet{shadecolor}{gray!10}


\newcommand{\answerstart}{ \colorlet{shadecolor}{orange!20}
\begin{shaded} }
\newcommand{\answerend}{  \end{shaded} \colorlet{shadecolor}{gray!10}}
<!-- STUDENTS: DO NOT EDIT THE SECTION ABOVE 
start here, insert homework below -->

# Question 1




# Question 2



```
## 
## 	F test to compare two variances
## 
## data:  subper$conc by subper$wash_type
## F = 0.47299, num df = 15, denom df = 15, p-value = 0.1585
## alternative hypothesis: true ratio of variances is not equal to 1
## 95 percent confidence interval:
##  0.1652614 1.3537510
## sample estimates:
## ratio of variances 
##          0.4729934
```


# Question 3

No


# Question 4




Mean=2.775
SD= 13.74397




# Question 5



```
## 
## 	Paired t-test
## 
## data:  golf$distance[1:40] and golf$distance[41:80]
## t = 1.277, df = 39, p-value = 0.1046
## alternative hypothesis: true difference in means is greater than 0
## 95 percent confidence interval:
##  -0.8864239        Inf
## sample estimates:
## mean of the differences 
##                   2.775
```


# Question 6

We fail to reject the null hypotheses that coated balls do not decrease the average driving distance. (P-value=0.1046)





# Question 7

## Part 1 (A)
Can be done with a smaller sample size.

## Part 2 (B)
If we have the same variability for a paired and independent design, we should not use the paired design as we degrees of freedom by doing so.


# Question 8


## Part 1 (A)

$Y_{ij}=\mu_i+\epsilon_{ij}$


## Part 2 (B)

$Y_{ij}$ is the observed values for the group j and factor level i.

$\mu_i$ is the theoretical mean for the level i.

$\epsilon_{ij}$  is the the independent normal error.


## Part 3 (C)

$H_0=\mu_1=\mu_2=\mu_3=...=\mu_i$

$H_a=$ at least one of the $\mu_i$ differs.


# Question 9

## Part 1 (A)

$\bar{Y_1}=50.3$

$\bar{Y_2}=61.1$

$\bar{Y_3}=38.3$


## Part 2 (B)



$SS_{trt}=780.192$




# Question 10



\small
\begin{center}
\begin{tabular}{l | c c c c c}
\textbf{Source of Var} & \hspace{10pt} \textbf{df} \hspace{10pt}
& \textbf{Sum of Squares} & \textbf{Mean Square} & \textbf{F} & \textbf{p-value} \\
\hline
\textbf{Trtment} & 4 & 987.71 & 246.93 & 246.9275 & 33.0949 \\
\textbf{Error} & 25 & 186.53 & 7.4612 & --- & --- \\
\hline
\textbf{Total} & 29 & 1174.24 & --- & --- & --- \\
\end{tabular}
\end{center}


















# Appendix


```r
library(knitr)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(broom)
library(splines)
library(caret)
library(Matrix)
library(MASS)
library(formatR)
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE, fig.width = 4, 
    fig.height = 4, tidy = TRUE)
# Q1

perdata <- read.csv("PermethrinData.csv")
subper <- filter(perdata, spray_rate == "1x" & item_type == "onesie")



# Q2
var.test(subper$conc ~ subper$wash_type, alternative = "two.sided")

# Q4
golf <- read.csv("GolfBallData.csv")


d <- golf$distance[1:40] - golf$distance[41:80]
mean = mean(d)
sd = sd(d)

mean
sd


t.test(x = golf$distance[1:40], y = golf$distance[41:80], paired = T, alternative = "greater")


3 * (50.3 - 49.9)^3 + 3 * (61.1 - 49.9)^2 + 3 * (38.3 - 49.9)^2
```


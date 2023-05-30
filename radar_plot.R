# Script to create radar chart for multi-criteria analysis 
library(fmsb)
library(scales)

## In AHP, scores are used to quantify the performance of each 
## alternative with respect to the different criteria. The scores are
## normalized prior to calculating the overall score for each 
## alternative.

## The scores are normalized by dividing the score for one alternative 
## on the sum of scores for the criterium for all alternatives included
## in the analysis (Saaty 2006, https://doi.org/10.1016/j.ejor.2004.04.032).


## Create an empty dataframe to store the scores
scores <- data.frame(matrix(nrow = 2, ncol = 0)) 
rownames(scores) = c("Compost bedding", "Cubicle")
scores


## Animal welfare
scores$"Animal welfare" <-c(2.77/(2.77 + 2.59), 2.59/(2.77 + 2.59)) 


## Milk hygiene
## The scores for this criterion is based on the performance indicators
## log somatic cell count (logSCC) and frequency of cows with dirty udders. 
## The values for both indicators are inversed so that a higher value 
## represents better performance. The scores for milk hygiene were 
## calculated as an average of normalized indicator values.  

### logSCC
logSCC <- c(1-(1.93/(1.93 + 1.84)), 1-(1.84/(1.93 + 1.84)))
logSCC

### dirty_udder12
dirty_udder <- c(1-(0.738/(0.738 + 0.578)), 1-(0.578/(0.738 + 0.578)))
dirty_udder 

scores$"Milk hygiene" <- colMeans(rbind(logSCC, dirty_udder))
scores$"Milk hygiene"
scores


## Ease of handling 
scores$"Ease of handling" <- c(5.433333/(5.433333 + 5.705882), 5.705882/(5.433333 + 5.705882))


## Consumer opinion
scores$"Consumer opinion" <- c(7.051449/(7.051449 + 4.023829), 4.023829/(7.051449 + 4.023829))


## Nitrogen use efficiency
scores$"Nitrogen use efficiency" <- c(0.69/(0.69 + 0.74), 0.74/(0.69 + 0.74))
scores


## Herd profit
scores$"Herd profit" <- c(123217/(136865 +  123217), 136865/(136865 +  123217))

## The scores dataset now includes normalized performance scores for
## all six criteria and both housing systems.
scores


## To use the fmsb package, we have to add 2 lines to the dataframe: 
## the max and min of each variable to show on the plot!
scores <- rbind(rep(1,6) , rep(0,6) , scores)
rownames(scores)[1:2] <- c("max", "min")
scores


## Set graphic colors
colors_border <- c("grey92", "grey92", "darkolivegreen3", "steelblue4")

## scales::alpha used to modify colour transparency
colors_area <- alpha(colors_border, 0.3)

## fmsb::radarchart
radarchart( scores, 
            axistype=0 , 
            pty = 32,
            maxmin=F,
            # custom polygon
            pcol=colors_border,
            pfcol=colors_area, 
            plwd = 3 , plty=1,
            # custom grid
            cglcol="grey", cglty=1, axislabcol="black", 
            cglwd=0.8, 
            # custom labels
            vlcex=0.9,
            calcex = 0.8
)


## Add a legend
## legend(x=0.7, y=1, legend = rownames(scores[-c(1,2),]), bty = "n", pch=20 , col= c("darkolivegreen3", "steelblue4") , text.col = "grey40", cex=1.2, pt.cex=3)
legend(x=0.6, y=1.25, legend = "Compost bedding", bty = "n", 
       pch=15 , col= c("darkolivegreen3") , text.col = "black", 
       cex=1.2, pt.cex=3)

legend(x=0.6, y=1.1, legend = "Cubicle", bty = "n", 
       pch=15 , col= c("steelblue4") , text.col = "black", 
       cex=1.2, pt.cex=3)


# _____________________________________________________________________
# END
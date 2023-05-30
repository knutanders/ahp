# AHP script 2023-05-27.R

library(devtools)
devtools::install_github("gluc/ahp", build_vignettes = FALSE)
library(data.tree)
library(R6)
library(ahp)

housingAHP <- Load("housing_systems_2023-05-28a.ahp")
housingAHP

# print function requires the data.tree package 
print(housingAHP, filterFun = isNotLeaf)

Calculate(housingAHP)
print(housingAHP, priority = function(x) x$parent$priority["Total", x$name])

Visualize(housingAHP)
Analyze(housingAHP)
AnalyzeTable(housingAHP)


AnalyzeTable(housingAHP, 
             variable = "priority", 
             sort = "orig",
             pruneFun = function(node, decisionMaker) PruneByCutoff(node, decisionMaker, 0.05),
             weightColor = "skyblue",
             consistencyColor = "coral",
             alternativeColor = c("gold"))


# END _________________________________________________________________






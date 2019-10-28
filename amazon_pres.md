Forest Fires in the Brazilian Rainforests
========================================================
author: Dhruva Agrawal
date: 28/10/2019
autosize: true

First Slide
========================================================

In this given presentation, I have taken up a dataset from Kaggle, the dataset that provides information on Forest Fires that have occured in the forests of Brazil, in the years 1997 to 2017.

Using the given dataset, I have built a Shiny Web Application that allows a user to choose between the different years i.e. from 1997 to 2017, and make a plot of the NUMBER OF FOREST FIRES that have occured in the various regions of Brazil, i.e. the different rainforests.

Second Slide
========================================================

```r
source("helpers.R")
library(shiny)
library(plyr)
library(ggplot2)
library(rgeos)
library(maptools)
library(gpclib)
library(maps)
library(mapproj)
mydata <- read.csv("amazon.csv", stringsAsFactors = FALSE)
summary(mydata)
```

```
      year         state              month               number     
 Min.   :1998   Length:6454        Length:6454        Min.   :  0.0  
 1st Qu.:2002   Class :character   Class :character   1st Qu.:  3.0  
 Median :2007   Mode  :character   Mode  :character   Median : 24.0  
 Mean   :2007                                         Mean   :108.3  
 3rd Qu.:2012                                         3rd Qu.:113.0  
 Max.   :2017                                         Max.   :998.0  
     date          
 Length:6454       
 Class :character  
 Mode  :character  
                   
                   
                   
```
Third Slide
========================================================
  






```
Error in parse(text = x, srcfile = src) : 
  <text>:28:0: unexpected end of input
26:       #tags$style("body{background-color:lightyellow; color:brown}")
27:    ),
   ^
```

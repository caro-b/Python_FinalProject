#### task 1 ####

randomNumbers <- runif(100,1,100)
randomNumbers2 <- rnorm(100,1,100)
randomNumbers3 <- sample(100,100)

# plotting 4 plots next to eachother
par(mfrow=c(2,2))

# scatter plot
plot(randomNumbers, col="purple", pch=1, cex=1)

plot(randomNumbers2, col="blue", pch=1, cex=1)

plot(randomNumbers3, col="red", pch=1, cex=1)

# log transformation if data dowsn't follow normal distribution 
plot(log(randomNumbers3), col="red", pch=1, cex=1)

par(mfrow=c(1,1))

# histogram
hist(randomNumbers, col="green", xlab="Random Number", ylab="Frequency")

# boxplot
boxplot(randomNumbers, horizontal = TRUE, notch = TRUE)


#### task 2 ####
install.packages("raster")
library(raster)

germany <- getData("GADM", country = "DEU", level = 2)
plot(germany)

prec <- getData("worldclim", var = "prec", res = 0.5, lon = 10, lat = 51)
plot(prec)

# spatial cropping: crop() commands reduces the extent
prec_ger1 <- crop(prec, germany) 
spplot(prec_ger1)

# spatial masking: mask() masks out all values outside the border
prec_ger2 <- mask(prec_ger1, germany)
ssplot(prec_ger2)

#### TODO: exchange crop and mask - what happens? ####

#### TODO: plot the precipiation, re-run the code for different data and countries ####


#### officeR ####
install.packages("officer")
library(officer)
library(magrittr)

layout_summary(my_pres)

my_pres<-
  # Load template
  read_pptx("blank.pptx") %>%
  # Add a slide
  add_slide(layout="Title Slide", master="Office Theme")



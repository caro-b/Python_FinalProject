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
spplot(prec_ger2)

prec_avg <- cellStats(prec_ger2, stat="mean")


#### TODO: exchange crop and mask - what happens? ####
prec_ger1 <- mask(prec, germany) 
spplot(prec_ger1)

prec_ger2 <- crop(prec_ger1, germany)
spplot(prec_ger2)

# no difference?


#### TODO: plot the precipiation, re-run the code for different data and countries ####
afghanistan <- getData("GADM", country = "AFG", level = 2)
plot(afghanistan)

bio <- getData("worldclim", var = "bio", res = 5, lon = 68, lat = 34)
plot(bio)

bio_afg1 <- crop(bio, afghanistan) 
spplot(bio_afg1)

bio_afg2 <- mask(bio_afg1, afghanistan)
spplot(bio_afg2)


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



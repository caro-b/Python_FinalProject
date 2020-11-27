install.packages(c("fun", "sudoku", "devtools","colorfindr"))
library(devtools)
library(fun)

mine_sweeper()

library(sudoku)
playSudoku()

library(colorfindr)

difftime("2020-12-24", Sys.Date(), units = "mins")

#shortcut <- (alt -)

#### Importing & exporting files ####

test_excel <- read_excel("~/test_excel.xlsx")
summary(test_excel)
head(test_excel)

write.csv(test_excel, "C:/Users/carob/Documents/test_csv.csv")

#### Datapasta ####

install.packages("datapasta")
library(datapasta)


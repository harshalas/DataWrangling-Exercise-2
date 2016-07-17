### Data Wrangling Exercise 2

## Get required libraries
library(dplyr)
library(tidyr)
library(stringr)

## Step 0 : Load Data to R Dataframe

raw.titanic <- read.csv(file.choose()) # prompts you to choose the file to be loaded 

View(raw.titanic)

raw.titanic

## Get the "shape" of the data
dim(raw.titanic)
head(raw.titanic)
tail(raw.titanic)
str(raw.titanic)

## Step 1: Port of embarkation

## Check if there are empty values for embarked coulmn

embarked <- raw.titanic %>% filter(embarked == "")

## replace empty rows with "S"
raw.titanic$embarked <- sub("^$","S",raw.titanic$embarked)

## Step 2: Age - Replace missing Age values with mean of all the age Values

## check for NULL Values
raw.titanic %>% filter(is.na(age) == TRUE)

## count the number of null values 
count_of_null <- count(raw.titanic %>% filter(is.na(age) == TRUE))

count_of_null

## calculate mean age for all the records that is Not NULL
mean_age <- mean(raw.titanic$age,na.rm = TRUE)

## replace Null values with mean age 
raw.titanic$age <- with(raw.titanic, ifelse(is.na(age) == TRUE,mean_age,age))

## Verify there are no more NULL Values
raw.titanic %>% filter(is.na(age) == TRUE)

## Verify number of rows replaced is same as number of rows which had nulls initially
count_of_replaced <- count(raw.titanic %>% filter(age == mean_age))

count_of_null == count_of_replaced

##Step 3: Lifeboat - Fill these empty slots in boat column with a dummy value of 'NA'

## Check for empty Values
boat <- raw.titanic %>% filter(boat == "")

View(boat)

## replace empty rows with "NA"

raw.titanic$boat <- sub("^$","S",raw.titanic$boat)

## re-Check for empty Values and ensure there are 0 records
boat <- raw.titanic %>% filter(boat == "")
View(boat)

## Step 4: Cabin - Create a new column has_cabin_number which has 1 if there is a cabin number
## and 0 otherwise

raw.titanic <- mutate(raw.titanic,has_cabin_number=ifelse(cabin =="",0,1))

View(raw.titanic)

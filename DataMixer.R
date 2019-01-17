#January 16th 2019 BIOL 432 assignment 2
#Sarah Tucker SN:10060359


#Assignment description:
#Write a script called DataMixer.R that uses Regular Expressions and tidyr to do the following (listed above code)

#make sure dplyr is ready to use
library(dplyr)

#renamed FallopiaData.csv manually in my file folder to InData.csv and loaded it into R under/into the variable MyData
MyData<-read.csv("InData.csv", header=T)

#Reorder the columns so that they are in the order: 'Total', 'Taxon', 'Senario', 'Nutrients'
#remove the other columns, and filter out rows with 'Total' biomass < 60
#I checked to make sure it worked by using head()
ReOrg<-MyData%>%
  select(Total,Taxon,Scenario,Nutrients)%>%
  filter(Total>60)
head(ReOrg)


#If there is a column called 'Nutrients', replace each string with its first letter  
NutReplacer<-if ("Nutrients" %in% colnames(ConvertR)){  
  factor(c(gsub("(\\w)\\w+", "\\1", ConvertR$Nutrients)))}
#note for myself = factor turns list of strings into a factor with two levels of h and l


#Make a new column TotalG, which converts the 'Total' column from mg to grams AND replace Total with TotalG
ConvertR<-transmute(ReOrg, TotalG = Total/1000, Taxon, Scenario, Nutrients=NutReplacer)
head(ConvertR)

#Replace all periods . with commas , in the 'TotalG' column

nCommas <- gsub("\\D", ",", ConvertR$TotalG)
FinalData <- transmute(ConvertR, TotalG = nCommas, Taxon, Scenario, Nutrients)
head(FinalData)



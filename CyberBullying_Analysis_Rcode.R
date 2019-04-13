#https://community.rstudio.com/t/generate-a-data-frame-from-many-xml-files/10214

#This example requires xml2 R package
require(xml2)
library(caret)

library(devtools)
library(readr)

#Data Preparation
##First, we include the following packages:
require(jsonlite)
require(rjson)
require(modeltools)
require(NLP)
require(qdap)
require(slam)
require(SnowballC)
require(tm)
require(topicmodels)
require(corrplot)
require(ggplot2)
require(scatterplot3d)
require(RTextTools)
library(e1071)



#Parse XML
URL <- "C:/Users/Ojoniko Nathan Abah/Desktop/CyberBullying_RProject/rProject_repo/cyberbullying_dataset/DataReleaseDec2011/XMLMergedFile.xml"
XML_data <- read_xml(URL)

#retrieve text case
Nodes_0 <- xml_find_all(XML_data, "//TEXT")
cases <- as.character(gsub("</?[^>]+>", "", Nodes_0))

#retrieve answer
Nodes_1 <- xml_find_all(XML_data, "//ANSWER")
bully_or_not <- as.character(gsub("</?[^>]+>", "", Nodes_1))

#retrieve bullyword
Nodes_2 <- xml_find_all(XML_data, "//CYBERBULLYWORD")
bullyword <- as.character(gsub("</?[^>]+>", "", Nodes_2))

#Retreive severity
Nodes_3 <- xml_find_all(XML_data, "//SEVERITY")
severity <- as.character(gsub("</?[^>]+>", "", Nodes_3))

#Bind the vectors together as columns and convert the structure into a data frame
LABElData <- data.frame(cbind(cases,bully_or_not,bullyword,severity))
write.csv(LABElData,'C:\\Users\\Ojoniko Nathan Abah\\Desktop\\bullyingdata.csv', row.names = FALSE)


#doc_matrix <- create_matrix(LABElData$bullyword, language="english", removeNumbers=TRUE,
#                            stemWords=TRUE, removeSparseTerms=.998)
#container <- create_container(doc_matrix, df2$class, trainSize=1:546, testSize=547:13299, virgin=FALSE)


#validation_index <- createDataPartition(LABElData$bullyword, p=0.80, list = FALSE)

#validation <- LABElData[-validation_index,]

#LABElData <- LABElData[validation_index,]

#dim(LABElData)

#sapply(LABElData, class)

#head(LABElData)

#levels(LABElData$bullyword)

#percentage <- prop.table(table(LABElData$bullyword))*100
#cbind(freq=table(LABElData$bullyword), percentage=percentage)

#summary(LABElData)

#x <- LABElData[,1:3]
#y <- LABElData[,4]

#par(mfrow=c(1,3))
#  for(i in 1:3){
#  boxplot(x[,i], main=names(iris)[i])  
#}

bullywords <- read_csv("C:\\Users\\Ojoniko Nathan Abah\\Desktop\\bullyingdata.csv")

str(bullywords)

bullyword_text <- bullywords$bullyword

library(tm)

bullyword_source <- VectorSource(bullyword_text)

bullyword_corpus <- VCorpus(bullyword_source)

bullyword_corpus[[15]][1]

tolower(bullyword_text)

removePunctuation(bullyword_text)

removeNumbers(bullyword_text)

stripWhitespace(bullyword_text)

library(qdap)

bracketX(bullyword_text)

replace_number(bullyword_text)

replace_abbreviation(bullyword_text)

replace_contraction(bullyword_text)

replace_symbol(bullyword_text)

new_stops <- c("n/a", "na", stopwords("en"))

removeWords(bullyword_text, new_stops)

frequent_terms <- freq_terms(bullyword_text, 50)
plot(frequent_terms)

clean_corpus<-function(corpus){
  corpus<- tm_map(corpus, stripWhitespace)
  corpus<- tm_map(corpus, removePunctuation)
  corpus<- tm_map(corpus, content_transformer(tolower))
  corpus<- tm_map(corpus, removeWords, stopwords("en"))
  corpus<- tm_map(corpus, removeWords, "na")
    return(corpus)
}

clean_corp <- clean_corpus(bullyword_corpus)

clean_corp[[227]][1]

bullywords_dtm <- DocumentTermMatrix(clean_corp)
bullywords_dtm
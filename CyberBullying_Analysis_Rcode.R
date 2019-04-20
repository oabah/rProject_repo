#Import libraries
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer) 
library(e1071)         #For Naive Bayes
library(caret)         #For the Confusion Matrix

#Import data
sms_raw <- read.csv("C:\\Users\\Ojoniko Nathan Abah\\Desktop\\bullyingdataset.csv")
head(sms_raw)

sms_raw <- sms_raw[, 2:3]
colnames(sms_raw) <- c("Msg", "Tag")
str(sms_raw)

#Find the proportions of junk vs legitimate sms messages
table(sms_raw$Tag)
prop.table(table(sms_raw$Tag))



bullyword <- subset(sms_raw, Tag == "Yes")
wordcloud(bullyword$Msg, max.words = 60, colors = brewer.pal(7, "Paired"), random.order = FALSE)


nonbullyword <- subset(sms_raw, Tag == "No")
wordcloud(nonbullyword$Msg, max.words = 60, colors = brewer.pal(7, "Paired"), random.order = FALSE)


sms_corpus <- VCorpus(VectorSource(sms_raw$Msg))

sms_dtm <- DocumentTermMatrix(sms_corpus, control = 
                                list(tolower = TRUE,
                                     removeNumbers = TRUE,
                                     stopwords = TRUE,
                                     removePunctuation = TRUE,
                                     stemming = TRUE))

dim(sms_dtm)


#Training & Test set
sms_dtm_train <- sms_dtm[1:9457, ]
sms_dtm_test <- sms_dtm[9458:10572, ]

#Training & Test Label
sms_train_labels <- sms_raw[1:9457, ]$Tag
sms_test_labels <- sms_raw[9458:10572, ]$Tag

#Proportion for training & test labels
prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

threshold <- 0.1

min_freq = round(sms_dtm$nrow*(threshold/100),0)

min_freq

# Create vector of most frequent words
freq_words <- findFreqTerms(x = sms_dtm, lowfreq = min_freq)

str(freq_words)

#Filter the DTM
sms_dtm_freq_train <- sms_dtm_train[ , freq_words]
sms_dtm_freq_test <- sms_dtm_test[ , freq_words]

dim(sms_dtm_freq_train)sms_dtm_freq_train <- sms_dtm_train[ , freq_words]
sms_dtm_freq_test <- sms_dtm_test[ , freq_words]

dim(sms_dtm_freq_train)


convert_values <- function(x) {
  x <- ifelse(x > 0, "Yes", "No")
}

sms_train <- apply(sms_dtm_freq_train, MARGIN = 2,
                   convert_values)
sms_test <- apply(sms_dtm_freq_test, MARGIN = 2,
                  convert_values)

#Create model from the training dataset
sms_classifier <- naiveBayes(sms_train, sms_train_labels)

#Make predictions on test set
sms_test_pred <- predict(sms_classifier, sms_test)

#Create confusion matrix
confusionMatrix(data = sms_test_pred, reference = sms_test_labels , positive = "Yes", dnn = c("Prediction", "Actual"))
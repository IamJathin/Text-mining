library(pdftools)
library(tm)
library(qdap)
library(stringr)
library(wordcloud)
library(viridisLite)
library(RWeka)

#create bigrams
tokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min = 2, max = 2))
}

text <- pdf_text("C:/Users/jathi/Desktop/StatisticsInR.pdf")
processed.text <- tolower(text)
processed.text <- removePunctuation(processed.text)
processed.text <- removeNumbers((processed.text))
processed.text <- stripWhitespace((processed.text))
processed.text <- removeWords(processed.text, c(stopwords("en")))

processed.text.split <- str_split(processed.text, pattern = ".")
processed.text.split <- unlist(processed.text.split, use.names=FALSE)
processed.corpus <- VCorpus(VectorSource(processed.text))

#weighting = weightTfIdf gives the term weights
processed.tdm <- DocumentTermMatrix(processed.corpus, control = list(tokenize = tokenizer, weighting = weightTfIdf))
processed.matrix <- as.matrix(processed.tdm)
word_frequency = colSums(processed.matrix)
names <- colnames(processed.matrix)

color_pal <- cividis(n = 2)              
wordcloud(names, word_frequency , max.words = 10, colors = "red")



                                    

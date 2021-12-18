#데이터를 획득하고 모델을 적용하기 위한 준비과정
library(rpart)
library(randomForest)
library(class)
library(e1071)


ucla = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit = factor(ucla$admit)

str(ucla)
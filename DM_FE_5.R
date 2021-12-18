#데이터를 획득하고 모델을 적용하기 위한 준비과정
library(rpart)
library(randomForest)
library(class)
library(e1071)


ucla = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit = factor(ucla$admit)

str(ucla)

#학습데이터와 테스트데이터로 분리
n = nrow(ucla)
idx = 1:n
idx.train = sample(idx, n* 0.6)
idx.test = setdiff(idx, idx.train)
ucla.train = ucla[idx.train, ]
ucla.test = ucla[idx.test, ]

str(ucla.train)
str(ucla.test)

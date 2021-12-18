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

#학습데이터로 모델 작성
#결정 트리
dt = rpart(admit~., data = ucla.train)
#랜덤포레스트
rf50 = randomForest(admit~., data = ucla.train, ntree = 50)
rf1000 = randomForest(admit~., data = ucla.train, ntree = 1000)
#KNN
k = knn(ucla.train, ucla.test, ucla.train$admit, k = 5)
#SVM
sr = svm(admit~., data = ucla.train)
sp = svm(admit~., data = ucla.train, kernel = 'polynomial')

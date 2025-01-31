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
k = knn(ucla.train, ucla.test, ucla.train$admit, k = 3, prob = TRUE)
#SVM
sr = svm(admit~., data = ucla.train)
sp = svm(admit~., data = ucla.train, kernel = 'polynomial')


#작성한 모델을 테스트 데이터로 예측, 혼동행렬 출력

dt.CM = table(test = ucla.test$admit,
              predict = predict(dt, ucla.test, type = 'class'))

rf50.CM = table(test = ucla.test$admit,
                predict = predict(rf50, ucla.test))

rf1000.CM = table(test = ucla.test$admit,
                  predict = predict(rf1000, ucla.test))

k.CM = table(test = ucla.test$admit,
             predict = k)

sr.CM = table(test = ucla.test$admit,
              predict = predict(sr, ucla.test))

sp.CM = table(test = ucla.test$admit,
              predict = predict(sp, ucla.test))

dt.CM
rf50.CM
rf1000.CM
k.CM
sr.CM
sp.CM

#각 혼동행렬로 부터 정확도 계산
#코드 작성 간략화를 위한 계산&출력 함수 작성
CM_acu.cal = function(CM_table) {
  result = (CM_table[1:1] + CM_table[2:2]) / sum(CM_table) * 100
  return(paste(round(result, 2), "%"))
}

#결과 출력
data.frame(model = c("Decision Tree",
                     "RandomForest(t=50)",
                     "RandomForest(t=1000)",
                     "K-NN",
                     "SVM radial",
                     "SVM Polynomial"),
           Accuracy = c(CM_acu.cal(dt.CM), 
                        CM_acu.cal(rf50.CM), 
                        CM_acu.cal(rf1000.CM), 
                        CM_acu.cal(k.CM), 
                        CM_acu.cal(sr.CM), 
                        CM_acu.cal(sp.CM)))


library(jmotif)
library(mclust)

#read file into dataframe
train1 = read.table('train2.txt',header = FALSE)
test1 = read.table('test2.txt', header=FALSE)

labels_train = as.numeric(as.numeric(train1$V1))
labels_test = as.numeric(test1$V1)
data_train = data.matrix(train1[,-1])
data_test = data.matrix(test1[,-1])

mylist = list(labels_train, labels_test, data_train, data_test)


# set the discretization parameters
#
w <- 35 # the sliding window size
p <- 8 # the PAA size
a <- 3  # the SAX alphabet size

class1 <- manyseries_to_wordbag(mylist[[3]][mylist[[1]] ==1,], w, p, a, 'exact', 0.01)
class2 <- manyseries_to_wordbag(mylist[[3]][mylist[[1]] ==2,], w, p, a, 'exact', 0.01)
class3 <- manyseries_to_wordbag(mylist[[3]][mylist[[1]] ==3,], w, p, a, 'exact', 0.01)
class4 <- manyseries_to_wordbag(mylist[[3]][mylist[[1]] ==4,], w, p, a, 'exact', 0.01)
class5 <- manyseries_to_wordbag(mylist[[3]][mylist[[1]] ==5,], w, p, a, 'exact', 0.01)
class6 <- manyseries_to_wordbag(mylist[[3]][mylist[[1]] ==6,], w, p, a, 'exact', 0.01)
class7 <- manyseries_to_wordbag(mylist[[3]][mylist[[1]] ==7,], w, p, a, 'exact', 0.01)

tfidf = bags_to_tfidf( list("class1" = class1, "class2" = class2, "class3" = class3, 
                            "class4" = class4, "class5"= class5, "class6" = class6, "class7"= class7) )


labels_predicted = rep(-1, length(mylist[2]))
labels_test = test1$V1
data_test = data.frame(mylist[4])

for (i in c(1:length(data_test[,1]))) {
  series = data_test[i,]
  series = as.numeric(series)
  bag = series_to_wordbag(series, w, p, a, "exact", 0.01)
  cosines = cosine_sim(list("bag"=bag, "tfidf" = tfidf))
  labels_predicted[i] = which(cosines$cosines == max(cosines$cosines))
}

# compute the classification error
#

classError(labels_predicted, labels_test)


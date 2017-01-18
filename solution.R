library(doMC)
registerDoMC()

## Absolute direction of the files
data.dir = '~/Documents/Kaggle-Facial-Keypoints-Detection/data/'
train.file = paste0(data.dir, 'training.csv')
test.file = paste0(data.dir, 'test.csv')

## Loading training data
d.train = read.csv(train.file, stringsAsFactors = F)
im.train = d.train$Image
d.train$Image = NULL

## Parallelization to convert all the image strings to integer
im.train = foreach(im = im.train, .combine=rbind) %dopar% {
  as.integer(unlist(strsplit(im," ")))
}


## Loading test data
d.test = read.csv(test.file, stringsAsFactors = F)

## Parallelization to convert all the image strings to integer
im.test = foreach(im = d.test$Image, .combine = rbind) %dopar% {
  as.integer(unlist(strsplit(im, " ")))
}
d.test$Image = NULL

save(d.train, im.train, d.test, im.test, file = 'data.Rd')

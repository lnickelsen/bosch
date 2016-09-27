
library("mxnet");

setwd("/Users/lnickelsen/Documents/DataScience/kaggle/bosch")

# accessing data size
system("cat train_numeric.csv | wc -l")
# 1183748 lines x 970 variables in a 2 gb file and that's just one of the files
system("cat test_numeric.csv | wc -l")
# 1183749 lines x 970 variables

# having a peak at the data
system("head train_numeric.csv")

# read only first 1000 lines for a start
df = read.csv(file="train_numeric.csv",nrows=10000)

# looking at the distribution of the response file 
hist(df$Response)
# it is binary with a lot of zeros

# how many zeros?
sum(df$Response==0)
summary(df$Response)
# around 0.568 % products have an error within the first 100000 lines

# defining x and y
train.x=as.matrix(df[,2:969])
train.y=as.numeric(df[,970]) # needs to be an array for mxnet

# setting up the network model (no deep learning for now)
data = mx.symbol.Variable('data')
fc1 = mx.symbol.FullyConnected(data=data, num_hidden=512)  # 2^9
act1 = mx.symbol.Activation(data=fc1, act_type="relu")
fc2 = mx.symbol.FullyConnected(data=act1, num_hidden=32)   # 2^5
act2 = mx.symbol.Activation(data=fc2, act_type="relu")
fc3 = mx.symbol.FullyConnected(data=act2, num_hidden=2)    # 2^1
net = mx.symbol.SoftmaxOutput(data=fc3)

# train
device = mx.cpu();
model <- mx.model.FeedForward.create(
  X                  = t(train.x),
  y                  = train.y,
  #  eval.data          = list("data"=t(as.matrix(train.x.eval)),"label"=train.y.eval),
  ctx                = device,    # device is either the cpu or gpu (graphical processor unit)
  symbol             = net,       # this is the network structure
  #eval.metric        = mx.metric.mlogloss,
  eval.metric        = mx.metric.accuracy,
  num.round          = 10,       # how many batches to work with
  learning.rate      = 1e-2,      # 0.01 is a good start
  momentum           = 0.9,       # using second derivative
  wd                 = 0.0001,    # what is this for?
  #initializer        = mx.init.normal(1/sqrt(nrow(train.x))),   # the standard devation is scaled with the number of
  #observations to prevent slow learning if by chance all weights are large or small
  #initializer        = mx.init.uniform(0.1),   # the standard devation is scaled with the number of 
  array.batch.size   = 500,
  #epoch.end.callback = mx.callback.save.checkpoint("titanic"),
  #batch.end.callback = mx.callback.log.train.metric(100),
  array.layout="colmajor"
);

dftest = read.csv(file="test_numeric.csv")
test.x=dftest[,2:969]

test.y=predict(model, as.matrix(test.x))

# attach to data.frame
testprwid=data.frame(t(test.y))
colnames(testprwid)=c("Id","Response")
testpr=data.frame(id=test$Id,testprwid)
rownames(testpr) = NULL
# write to csv-file
write.csv(testpr,file="bosch_mxnet_subm.csv",quote=FALSE,row.names=FALSE)

import os
import numpy as np
#import csv
import pandas as pd
import sklearn
from sklearn.ensemble import RandomForestClassifier
from numpy import genfromtxt, savetxt
# from matplotlib
from sklearn.preprocessing import Imputer


os.chdir('/Users/lnickelsen/Documents/DataScience/kaggle/bosch')
df = pd.read_csv('train_numeric.csv', nrows=100000)

#df.shape()
#df.describe

target = df[['Response']]
target.describe()

train = df.ix[:,0:969]
train.isnull().sum()

# create imputer to replace missing values with the mean or median
# replace later by a more sophisticated imputation approach
imp = Imputer(missing_values='NaN', strategy='median', axis=0)
# do the fit and also transform (predict) the NaN-data in one step (overwriting train here)
train = imp.fit_transform(train)

# now do the RandomForest fit
rf = RandomForestClassifier(n_estimators=10)
rf.fit(train, target)

# read test data and also impute
# need to do the loop because of memory overload of my laptop
for ii in range(0,9):
    test = pd.read_csv('test_numeric.csv',nrows=100000, skiprows=ii*100000)
    test = imp.fit_transform(test)
    testid=test[:,0]

    # do the actual prediction
    testpredict=rf.predict(test)

    # probably clumsy method to get the correct array format
    testtemp=np.vstack((testid,testpredict))
    testidandpre=testtemp.transpose()
    testidandpre.shape

    # write results to submission file
    savetxt("bosch_submission_" + str(ii) + ".csv", testidandpre, delimiter=',', fmt='%d')


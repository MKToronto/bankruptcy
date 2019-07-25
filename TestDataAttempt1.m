yfit = trainedClassifier.predictFcn(Year5_Table)
trainedClassifier.HowToPredict
confusionmat(yfit,trainedClassifier.predictFcn(Year5_Table))


% Create a cvpartition object that defined the folds
c = cvpartition(Y,'holdout',.2);

% Create a training set
x = X(training(c,1),:);
y = Y(training(c,1));
% test set
u=X(test(c,1),:);
v=Y(test(c,1),:);

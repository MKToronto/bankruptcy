%load Year3NormalisedandSplit.mat

%Using the training dataset, we're running the random forest model 6 times,
%with the parameters of [10, 20, 50, 100, 200, 500]. 
  
%RF with 10 Trees    
Mdl10 = TreeBagger(10, dataTraining,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl10.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 10 trees 
figure;
oobErrorBaggedEnsemble10 = oobError(Mdl10);
plot(oobErrorBaggedEnsemble10)

%RF with 20 Trees    
Mdl20 = TreeBagger(20, dataTraining,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl20.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 20 trees
figure;
oobErrorBaggedEnsemble20 = oobError(Mdl20);
plot(oobErrorBaggedEnsemble20)

%RF with 50 Trees    
Mdl50 = TreeBagger(50, dataTraining,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl50.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 50 trees
figure;
oobErrorBaggedEnsemble50 = oobError(Mdl50);
plot(oobErrorBaggedEnsemble50)

%RF with 100 Trees    
Mdl100 = TreeBagger(100, dataTraining,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl100.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 100 trees
figure;
oobErrorBaggedEnsemble100 = oobError(Mdl100);
plot(oobErrorBaggedEnsemble100)

%RF with 250 Trees    
Mdl250 = TreeBagger(250, dataTraining,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl250.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 250 trees
figure;
oobErrorBaggedEnsemble250 = oobError(Mdl250);
plot(oobErrorBaggedEnsemble250)

%RF with 500 Trees    
Mdl500 = TreeBagger(500, dataTraining,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl500.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 500 trees
figure;
oobErrorBaggedEnsemble500 = oobError(Mdl500);
plot(oobErrorBaggedEnsemble500)

%To show the misclassification probability for out-of-bag observations in
%the training data. Conculsion: Based on the graphs, it appears that around
%50 trees is the optimal amount of trees for this dataset. 

hold on

plot(oobErrorBaggedEnsemble10)
plot(oobErrorBaggedEnsemble20)
plot(oobErrorBaggedEnsemble50)
plot(oobErrorBaggedEnsemble100)
plot(oobErrorBaggedEnsemble250)
plot(oobErrorBaggedEnsemble500)

xlabel 'Number of grown trees';
ylabel 'Classification error';
title('Out-of-Bag Errors for Training Data')
legend('10 Trees','20 Trees', '50 Trees', '100 Trees', '250 Trees', '500 Trees')
hold off
%load Year3NormalisedandSplit.mat

%Using the training dataset with a 90% holdout percentage, we're running 
%the random forest model 6 times, with the parameters of 
%[10, 20, 50, 100, 200, 500]. 
  
%RF with 10 Trees    
Mdl10_90 = TreeBagger(10, dataTraining90,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl10_90.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 10 trees 
figure;
oobErrorBaggedEnsemble10_90 = oobError(Mdl10_90);
plot(oobErrorBaggedEnsemble10_90)

%RF with 20 Trees    
Mdl20_90 = TreeBagger(20, dataTraining90,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl20_90.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 20 trees
figure;
oobErrorBaggedEnsemble20_90 = oobError(Mdl20_90);
plot(oobErrorBaggedEnsemble20_90)

%RF with 50 Trees    
Mdl50_90 = TreeBagger(50, dataTraining90,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl50_90.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 50 trees
figure;
oobErrorBaggedEnsemble50_90 = oobError(Mdl50_90);
plot(oobErrorBaggedEnsemble50_90)

%RF with 100 Trees    
Mdl100_90 = TreeBagger(100, dataTraining90,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl100_90.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 100 trees
figure;
oobErrorBaggedEnsemble100_90 = oobError(Mdl100_90);
plot(oobErrorBaggedEnsemble100_90)

%RF with 250 Trees    
Mdl250_90 = TreeBagger(250, dataTraining90,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl250_90.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 250 trees
figure;
oobErrorBaggedEnsemble250_90 = oobError(Mdl250_90);
plot(oobErrorBaggedEnsemble250_90)

%RF with 500 Trees    
Mdl500_90 = TreeBagger(500, dataTraining90,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl500_90.Trees{1},'Mode','graph')

%shows the out of bag error on a graph for 500 trees
figure;
oobErrorBaggedEnsemble500_90 = oobError(Mdl500_90);
plot(oobErrorBaggedEnsemble500_90)

%To show the misclassification probability for out-of-bag observations in
%the training data. Conculsion: Based on the graphs, it appears that around
%50 trees is the optimal amount of trees for this dataset. 

hold on

plot(oobErrorBaggedEnsemble10_90)
plot(oobErrorBaggedEnsemble20_90)
plot(oobErrorBaggedEnsemble50_90)
plot(oobErrorBaggedEnsemble100_90)
plot(oobErrorBaggedEnsemble250_90)
plot(oobErrorBaggedEnsemble500_90)

xlabel 'Number of grown trees';
ylabel 'Classification error';
title('Out-of-Bag Errors for Training Data with 90% Holdout')
legend('10 Trees','20 Trees', '50 Trees', '100 Trees', '250 Trees', '500 Trees')
hold off
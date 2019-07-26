%load Year3NormalisedandSplit.mat

%We are using the TRAINING data to set the model. Based off the parameter tests, 
%we chose to use 50 trees during the rest of our experiements, as that
%provided optimal stopping criteara, as there was no improvment over time and 
% based on Ockham's razor principle of using the most simple model. 
   
Mdl = TreeBagger(50, dataTraining,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl.Trees{1},'Mode','graph')

%To show the misclassification probability for out-of-bag observations in
%the training data.
figure;
oobErrorBaggedEnsemble = oobError(Mdl);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Classification error';
title('Error for both Training and Testing Data')

%First used the 'OOBVarImp' function to see the importance of the
%attributes for prediction error in the model. We noticed that everytime 
%the model was run, there would be a different, but similar result on the graph. To explore this, 
%we created 3 RF models - using the parameters of 50 trees - and ran the
%'OOBVarImp'. Conclusion: Consistant with the 'randomness' of the Random
%Forest, we can see that for each model run, we get a similar trend for the
%feature importance for prediction error, but not the same; the most important features are
%mostly consistant and the lest important features are mostly
%consistant. This could be explored more in future work. 

Mdl_OOBVarImp = TreeBagger(50, dataTraining,'class','Method','Classification','OOBVarImp','On');
b1 = Mdl_OOBVarImp.OOBPermutedVarDeltaError;

hold on
plot(b1)

Mdl_OOBVarImp2 = TreeBagger(50, dataTraining,'class','Method','Classification','OOBVarImp','On');
b2 = Mdl_OOBVarImp2.OOBPermutedVarDeltaError;
plot(b2)

Mdl_OOBVarImp3 = TreeBagger(50, dataTraining,'class','Method','Classification','OOBVarImp','On');
b3 = Mdl_OOBVarImp3.OOBPermutedVarDeltaError;
plot(b3)
xlabel 'Attributes';
ylabel 'Feature Importance for Prediction Error';
title('Feature Importance for Prediction Error for 3 RF Models with 50 Trees')
legend('Model 1','Model 2', 'Model 3')
hold off 

%using the dataTesting to predict bankruptcy / not bankruptcy. 
%the Yfit vector are the predictions for the dataTesting
[Yfit_training,scores] = predict(Mdl,dataTraining);


%to check the accuracy of the model for the dataTraining, we created a loop
k= 0;
for i = 1:size(dataTraining,1) %for the loop, to go through every row
    if str2double(Yfit_training{i,1}) == str2double(dataTraining{i,65}) %comparing each prediction with each actual value
        k = k + 1; %counting everytime the condition is met
    end
end

accuracy_training = k / size(dataTraining,1) %ratio of correct predictions
accuracy_training2 = numel(find(str2double(dataTraining{:,65})-str2double(Yfit_training)==0))/numel(dataTraining{:,65})


%Now we move on to the TESTING DATA SET using the same model from the
%training data. Using the dataTesting to predict bankruptcy / not bankruptcy. 

[Yfit_Test,scores_Test] = predict(Mdl,dataTesting);

%shows the feature importance error - ran three times to see if there is a
%global trend how it varies between different random forests. 

%Mdl_OOBVarImpTesting = TreeBagger(50, dataTesting,'class','Method','Classification','OOBVarImp','On');
%b1Test = Mdl_OOBVarImpTesting.OOBPermutedVarDeltaError;
hold on
plot(b1Test)

%Mdl_OOBVarImpTesting2 = TreeBagger(50, dataTesting,'class','Method','Classification','OOBVarImp','On');
%b1Test2 = Mdl_OOBVarImpTesting2.OOBPermutedVarDeltaError;
plot(b1Test2)

%Mdl_OOBVarImpTesting3 = TreeBagger(50, dataTesting,'class','Method','Classification','OOBVarImp','On');
%b1Test3 = Mdl_OOBVarImpTesting3.OOBPermutedVarDeltaError;
plot(b1Test3)

xlabel 'Attributes';
ylabel 'Feature Importance for Prediction Error_Testing';
title('Feature Importance for Prediction Error for 3 RF Models with 50 Trees_Testing')
legend('Model 1','Model 2', 'Model 3')
hold off 

hold off
figure;
oobErrorBaggedEnsemble = oobError(Mdl);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Classification error';
title('Error for both Training and Testing Data')
hold on
err = error(Mdl, dataTesting(:, 1:64), dataTesting(:,65));
plot(err)
legend('Out-of-bag (Training) Error','Testing Error')
hold off 



%We want to count to check the accuracy of the model for the dataTesting
q = 0;
for r = 1:size(dataTesting,1) 
    if str2double(Yfit_Test{r,1}) == str2double(dataTesting{r,65}) 
        q = q + 1; 
    end
end

accuracy_testing = q / size(dataTesting,1) %ratio of correct predictions
accuracy_testing2 = numel(find(str2double(dataTesting{:,65})-str2double(Yfit_Test)==0))/numel(dataTesting{:,65})


%get testing data into the correct data type
dataTesting_Array = table2array(dataTesting(:,65));

%create a confusionmat; it shows the predicted no/actual no and predicted
%yes/actual yes. 
C_tb = confusionmat(dataTesting_Array,Yfit_Test);
C_tb2 = bsxfun(@rdivide,C_tb,sum(C_tb,2)) * 100;
disp(C_tb)
disp(C_tb2)

%plot the confusion matrix
DT = transpose(str2double(dataTesting{:,65}));
DP = transpose(str2double(Yfit_Test));

plotconfusion(DT,DP) 

%conculsion: when looking at the CM, you can see how good the model is at
%predicting not bankrupt companies, but it is not accurate when it comes
%to predicting bankrupt companies. While it got 99.7% of the not bankrupt
%correct, it only got 3.8% bankrupt correct. The total accuracy rate of
%95.7% is misleading because it's taking the total amount of bankrupt and
%not bankrupt, and since there are so many more not bankrupt companies, the
%accuracy gets skewed towards showing the accuracy of the not bankrupt.
%Ultimately, even if the model is good at predicting not bankruptcy,
%that's not what is important in our goal, which is to predict bankrupt
%companies. 

%check to see that the confusion matrix is structured as expected, so we're
%counting how many predicted and actual bankrupt/not bankrupt 

count_b_pred = numel(find(str2double(Yfit_Test)==1))
disp(count_b_pred)

count_nb_pred = numel(find(str2double(Yfit_Test)==0))
disp(count_nb_pred)

count_b_testing = numel(find(str2double(dataTesting{:,65})==1))
disp(count_b_testing)

count_nb_testing = numel(find(str2double(dataTesting{:,65})==0))
disp(count_nb_testing)


%ROC CURVE 
[X,Y,T,AUC] = perfcurve(dataTesting_Array,scores_Test(:,2),'1');
plot(X,Y)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC for Classification by Random Forest')

%we get great accuracy and low training error, but when you look at the
%confusion matrix, this model is not very good at predicting bankrupcy. Future work
%is to do this on different data that has more bankrupt cases to teach the
%model what a bankrupt case looks like (bc there is such a small amount of
%bankrupt cases compared to not bankrupt)



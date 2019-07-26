%load Year3NormalisedandSplit.mat

%We are using the TRAINING data to set the model. We are using the data
%with a holdout percentage of 90/10. Based on the parameter tests for the 
%90% holdout, we're running the accuracy with 50 trees. 
   
Mdl_90 = TreeBagger(50, dataTraining90,'class','OOBPrediction','On',...
    'Method','classification');

view(Mdl_90.Trees{1},'Mode','graph')

%To show the misclassification probability for out-of-bag observations in
%the training data.
figure;
oobErrorBaggedEnsemble_90 = oobError(Mdl_90);
plot(oobErrorBaggedEnsemble_90)
xlabel 'Number of grown trees';
ylabel 'Classification error';
title('Error for both Training (90%) and Testing (10%) Data')

%We are doing the another 'OOBVarImp' function experiment to see the importance of the
%attributes for prediction error in the model using the 90% holdout training data. We noticed
%very similar results as we did with the 70% holdout training method. 

Mdl_OOBVarImp_90 = TreeBagger(50, dataTraining90,'class','Method','Classification','OOBVarImp','On');
b1_90 = Mdl_OOBVarImp_90.OOBPermutedVarDeltaError;

hold on
plot(b1_90)

Mdl_OOBVarImp2_90 = TreeBagger(50, dataTraining90,'class','Method','Classification','OOBVarImp','On');
b2_90 = Mdl_OOBVarImp2_90.OOBPermutedVarDeltaError;
plot(b2_90)

Mdl_OOBVarImp3_90 = TreeBagger(50, dataTraining90,'class','Method','Classification','OOBVarImp','On');
b3_90 = Mdl_OOBVarImp3_90.OOBPermutedVarDeltaError;
plot(b3_90)
xlabel 'Attributes';
ylabel 'Feature Importance for Prediction Error';
title('Feature Importance for Prediction Error for 3 RF Models with 50 Trees and 90% Holdout')
legend('Model 1','Model 2', 'Model 3')
hold off 

%using the dataTesting90 to predict bankruptcy / not bankruptcy. 
%the Yfit vector are the predictions for the dataTesting
[Yfit_training_90,scores_90] = predict(Mdl_90,dataTraining90);


%to check the accuracy of the model for the dataTraining90

accuracy_training2_90 = numel(find(str2double(dataTraining90{:,65})-str2double(Yfit_training_90)==0))/numel(dataTraining90{:,65})


%Now we move on to the TESTING DATA SET using the same model from the
%training data. Using the dataTesting to predict bankruptcy / not bankruptcy. 

[Yfit_Test_90,scores_Test_90] = predict(Mdl_90,dataTesting90);

%shows the feature importance error of the testing data. Comparing the
%90%holdout outcome with the 70% holdout, there seems to be more volatility with
%the results from the 90% holdout, which makes sense since the testing data only has 10% of the
%samples. 

%Mdl_OOBVarImpTesting_90 = TreeBagger(50, dataTesting90,'class','Method','Classification','OOBVarImp','On');
%b1Test_90 = Mdl_OOBVarImpTesting_90.OOBPermutedVarDeltaError;
hold on
plot(b1Test_90)

%Mdl_OOBVarImpTesting2_90 = TreeBagger(50, dataTesting90,'class','Method','Classification','OOBVarImp','On');
%b1Test2_90 = Mdl_OOBVarImpTesting2_90.OOBPermutedVarDeltaError;
plot(b1Test2_90)

%Mdl_OOBVarImpTesting3_90 = TreeBagger(50, dataTesting90,'class','Method','Classification','OOBVarImp','On');
%b1Test3_90 = Mdl_OOBVarImpTesting3_90.OOBPermutedVarDeltaError;
plot(b1Test3_90)

xlabel 'Attributes';
ylabel 'Feature Importance for Prediction Error_Testing';
title('Feature Importance for Prediction Error for 3 RF Models with 50 Trees_Testing with 90% holdout')
legend('Model 1','Model 2', 'Model 3')
hold off 

%When we look at this graph, we see that the the training and testing data
%errors are more consistant and similar with a 90% holdout vs the 70% holdout. 
hold off
figure;
oobErrorBaggedEnsemble_90 = oobError(Mdl_90);
plot(oobErrorBaggedEnsemble_90)
xlabel 'Number of grown trees';
ylabel 'Classification error';
title('Error for both Training and Testing Data with 90% Holdout')
hold on
err_90 = error(Mdl_90, dataTesting90(:, 1:64), dataTesting90(:,65));
plot(err_90)
legend('Out-of-bag (Training) Error','Testing Error')
hold off 



%We want to count to check the accuracy of the model for the dataTesting90

accuracy_testing2_90 = numel(find(str2double(dataTesting90{:,65})-str2double(Yfit_Test_90)==0))/numel(dataTesting90{:,65})


%get testing data into the correct data type
dataTesting_Array_90 = table2array(dataTesting90(:,65));

%create a confusionmat; it shows the predicted no/actual no and predicted
%yes/actual yes. 
C_tb_90 = confusionmat(dataTesting_Array_90,Yfit_Test_90);
C_tb2_90 = bsxfun(@rdivide,C_tb_90,sum(C_tb_90,2)) * 100;
disp(C_tb_90)
disp(C_tb2_90)

%plot the confusion matrix with the 90% holdout. Based on the confusion
%matrix, using the 10% for the testing data, the model does even worse at
%predicting bankruptcy (accuracy for bankruptcy prediction is 2.2%,
%compared to 4.6%). This is most likely due to overfitting. 
DT_90 = transpose(str2double(dataTesting90{:,65}));
DP_90 = transpose(str2double(Yfit_Test_90));

plotconfusion(DT_90,DP_90) 


%ROC CURVE confirms the conculsion of the confusion matrix, the 90% holdout
%is less accurate for predicting bankruptcy. 
[X_90,Y_90,T_90,AU_90C] = perfcurve(dataTesting_Array_90,scores_Test_90(:,2),'1');
plot(X_90,Y_90)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC for Classification by Random Forest with 90% Holdout')




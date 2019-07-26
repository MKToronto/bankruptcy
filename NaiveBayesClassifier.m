%this is our main file for Naive Bayes. 

load NaiveBayesFinal.mat


% NAIVE BAYES CLASSIFIER


% Creating a training set
dataTrainingInstances = dataTraining(:,1:64);
dataTraininglabels = dataTraining(:,65);
% Creating a test set
dataTestingInstances=dataTesting(:,1:64);
dataTestingLabels=dataTesting(:,65);


% Try with a normal distribution parameter

        NB = fitcnb(dataTrainingInstances,dataTraininglabels,'ClassNames',{'1','0'},'Prior','empirical', 'DistributionNames', 'normal');
        NBCV = crossval(NB,'KFold',10);%105 fold validation is actually a leave one out validation
        NBTrainError = (loss(NB,dataTestingInstances,dataTestingLabels))*100
        NBValError = (kfoldLoss(NBCV, 'LossFun', 'ClassifError'))*100


NBResponse = predict(NB,dataTestingInstances);
dataTestingLabelsC = table2cell(dataTestingLabels)
NBconfusionmat = confusionmat(dataTestingLabelsC, NBResponse); 
NBTestError_normal = (loss(NB,dataTestingInstances,dataTestingLabels))*100 


%plot the confusion matrix
DT = transpose(str2double(dataTestingLabelsC));
DP = transpose(str2double(NBResponse));
figure(1)
plotconfusion(DT,DP); 




%ROC CURVES
[Xnb,Ynb,Tnb,AUCnb_normal] = perfcurve(str2double(dataTestingLabelsC),str2double(NBResponse),'1');

[Xrf,Yrf,Trf,AUCrf] = perfcurve(dataTesting_Array,scores_Test(:,2),'1');

figure(2)
plot(Xnb,Ynb)
hold on
plot(Xrf,Yrf)
legend('Naive Bayes','Random Forest','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for Naive Bayes and Random Forest Classification')
hold off





% Try with a kernel distribution parameter

        NB = fitcnb(dataTrainingInstances,dataTraininglabels,'ClassNames',{'1','0'},'Prior','empirical', 'DistributionNames', 'kernel');
        NBCV = crossval(NB,'KFold',10);%105 fold validation is actually a leave one out validation
        NBTrainError = (loss(NB,dataTestingInstances,dataTestingLabels))*100
        NBValError = (kfoldLoss(NBCV, 'LossFun', 'ClassifError'))*100


NBResponse = predict(NB,dataTestingInstances);
dataTestingLabelsC = table2cell(dataTestingLabels)
NBconfusionmat = confusionmat(dataTestingLabelsC, NBResponse); 
NBTestError_kernel = (loss(NB,dataTestingInstances,dataTestingLabels))*100 


%plot the confusion matrix
DT = transpose(str2double(dataTestingLabelsC));
DP = transpose(str2double(NBResponse));
figure(3)
plotconfusion(DT,DP); 




%ROC CURVES
[Xnb,Ynb,Tnb,AUCnb_kernel] = perfcurve(str2double(dataTestingLabelsC),str2double(NBResponse),'1');

[Xrf,Yrf,Trf,AUCrf] = perfcurve(dataTesting_Array,scores_Test(:,2),'1');

figure(4)
plot(Xnb,Ynb)
hold on
plot(Xrf,Yrf)
legend('Naive Bayes','Random Forest','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for Naive Bayes and Random Forest Classification')
hold off



% Since the kernel has a better AUC, will use kernel whilst also 
% trying with differenet prior parameter -
% The default'empirical' means the class prior probabilities are the class 
% relative frequencies of the class data.
% Instead a uniform distribution of prios are assumed ie All class prior 
% probabilities are equal to 1/K, where K is the number of classes.





% Kernal + Uniform

        NB = fitcnb(dataTrainingInstances,dataTraininglabels,'ClassNames',{'1','0'},'Prior','uniform', 'DistributionNames', 'kernel');
        NBCV = crossval(NB,'KFold',10);%105 fold validation is actually a leave one out validation
        NBTrainError = (loss(NB,dataTestingInstances,dataTestingLabels))*100
        NBValError = (kfoldLoss(NBCV, 'LossFun', 'ClassifError'))*100


NBResponse = predict(NB,dataTestingInstances);
dataTestingLabelsC = table2cell(dataTestingLabels)
NBconfusionmat = confusionmat(dataTestingLabelsC, NBResponse); 
NBTestError_kernel_uniform = (loss(NB,dataTestingInstances,dataTestingLabels))*100 


%plot the confusion matrix
DT = transpose(str2double(dataTestingLabelsC));
DP = transpose(str2double(NBResponse));
figure(5)
plotconfusion(DT,DP); 
title('Confusion Matrix for Naive Bayes (Kernel + Uniform Params)')



%ROC CURVES
[Xnb,Ynb,Tnb,AUCnb_kernel_uniform] = perfcurve(str2double(dataTestingLabelsC),str2double(NBResponse),'1');

[Xrf,Yrf,Trf,AUCrf] = perfcurve(dataTesting_Array,scores_Test(:,2),'1');

figure(6)
plot(Xnb,Ynb)
hold on
plot(Xrf,Yrf)
legend('Naive Bayes','Random Forest','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for Naive Bayes (Kernel + Uniform Params) and Random Forest Classification')
hold off






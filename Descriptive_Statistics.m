%this is our main file for Naive Bayes. 

load NaiveBayesFinal.mat

% Normalised Data set plotted

Year3_TableInstancesNormalised = Year3_Table(:,1:64)
Year3_TableInstancesArray = table2array(Year3_TableInstancesNormalised)
minYear3 = nanmin(Year3_TableInstancesArray)
maxYear3 = nanmax(Year3_TableInstancesArray)
meanYear3 = nanmean(Year3_TableInstancesArray)
sigmaYear3 = nanstd(Year3_TableInstancesArray)

 
% Plot the data and annotate the graph
plot(numberofcolumns,minYear3, numberofcolumns, maxYear3, numberofcolumns, meanYear3 )
legend('Min','Max','Mean')
xlabel('Features')
ylabel('Normalised Financial Ratio Values')
title('Exploring the Normalised data set - Min, Max, Mean values')


% Raw Data Plotted

Year3_TableInstances = Year3_Table_nonNormalised(:,1:64)
Year3_TableInstancesArray = table2array(Year3_TableInstances)
minYear3 = nanmin(Year3_TableInstancesArray)
maxYear3 = nanmax(Year3_TableInstancesArray)
meanYear3 = nanmean(Year3_TableInstancesArray)
sigmaYear3 = nanstd(Year3_TableInstancesArray)

% 
% Plot the data and annotate the graph
plot(numberofcolumns,minYear3, numberofcolumns, maxYear3, numberofcolumns, meanYear3 )
legend('Min','Max','Mean')
xlabel('Features')
ylabel('Financial Ratio Values')
title('Exploring the data set - Min, Max, Mean values')


% Tried it out taking logs
% yplotMin = (1.25).^(log10(minYear3));
% yplotMax = (1.25).^(log10(maxYear3));
% yplotMean = (1.25).^(log10(meanYear3));
% 
% plot(numberofcolumns,yplotMin, numberofcolumns, yplotMax, numberofcolumns, yplotMean )
% legend('Log of Min','Log of Max','Log of Mean')
% xlabel('Columns')
% ylabel('Value')


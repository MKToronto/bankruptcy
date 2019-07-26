%load Year3NormalisedandSplit.mat

Mdl = TreeBagger(500, dataTraining,'class','OOBPrediction','On',...
    'Method','classification') 


view(Mdl.Trees{1},'Mode','graph')

%shows the accuracy on a graph
figure;
oobErrorBaggedEnsemble = oobError(Mdl);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';

%using the dataTesting to predict bankruptcy / not bankruptcy. 
%the Yfit vector are the predictions for the dataTesting
%the score is how accurite??? 
[Yfit,scores] = predict(Mdl,dataTesting)

%to check the accuracy of the model for the dataTesting, we created a loop
%that 
k= 0
for i = 1:size(dataTesting,1) %for the loop, to go through every row
    if str2double(Yfit{i,1}) == str2double(dataTesting{i,65}) %comparing each prediction with each actual value
        k = k + 1; %counting everytime the condition is met
    end
end

l = k / size(dataTesting,1) %ratio of correct predictions

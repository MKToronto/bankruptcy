clear all;

load Year3NormalisedandSplit.mat

%the loop is to transform the dataTraining Table-object into double since
%pca generates an error when using an object and for some reasons the
%dataTraining table is full of doubles except for the last column (65)
%which is filled with cells
%We are getting rid of the last column since it is not an attribute
dataTrainingC = zeros(size(dataTraining,1),size(dataTraining,2)-1);
for k = 1:size(dataTraining,1)
    for i = 1:(size(dataTraining,2)-1)
        dataTrainingC(k,i) = dataTraining{k,i};
        %dataTrainingC(k,65) = str2double(dataTraining{k,65});
    end
end

coeff = pca(dataTrainingC); %we did the pca, but how do we translate this into something meaningful? I.e. what does the first column represent? Attribute #X? HOw do we know which one
%Also, how do we decide which attributes to retain in the next phase of the
%analysis? Each column of coeff contains coefficients for one principal component,
%and the columns are in descending order of component variance. So how do
%we know which column correspond to which component?

%coeff = pca(dataTrainingC,'Rows','pairwise'); %need to make table into a matrix? - do it on

[coeff,score,latent,tsquared,explained] = pca(dataTrainingC);

explained

scatter3(score(:,1),score(:,2),score(:,3),subtypes,{'b','g','m'})
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')

mapcaplot(score)

biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3','v_4'});


datalabels = dataTraining(1:end,65:65)
datalabelsArray = table2array(datalabels)
datalabelsDouble = double(dataTraining(1:end,65:65))

double(datalabelsArray)

gscatter(score(:,1),score(:,2),score(:,3),datalabelsArray)

figure
x1 = score(:,1);
x2 = score(:,2);
classes = datalabelsC;
sizes = 50 * ones(1,length(x1));
% Plot first class
scatter(x1(classes == 1), x2(classes == 1), 150, 'b', '*')
% Plot second class.
hold on;
scatter(x1(classes == 0), x2(classes == 0), 120, 'r', '*')

figure
scatter(x1(class == 1), 120, 'r', '*', x2(class == 1), 120, 'r', '*', x1(class == 0),120, 'b', '*' , x2(class == 0),120 ,'b', '*')



S = repmat([50,50,50],numel(datalabelsC/3),1);
C = repmat(datalabelsC,1,3);
s = S(:);
c = C(:);
x = score(:,1);
y = score(:,2);
z = score(:,3);

figure
scatter3(x,y,z,20,C)
view(40,35)




datalabelsC = zeros(size(datalabels));
for k = 1:size(datalabels)
    
        datalabelsC(k,1) = str2double(datalabels{k,1});
        %dataTrainingC(k,65) = str2double(dataTraining{k,65});
    
end
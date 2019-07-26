%%load Year3NormalisedandSplit.mat

%We are splitting the training and testing data into a 90%/10% split,
%respectively. We will rerun our experiments with this split to see if
%there is a different outcome. 

p90 = .9      % proportion of rows to select for training
N90 = size(Year3_Table,1)  % total number of rows 
tf90 = false(N90,1)    % create logical index vector
tf90(1:round(p90*N90)) = true     
tf90 = tf90(randperm(N90))   % randomise order
dataTraining90 = Year3_Table(tf90,:) 
dataTesting90 = Year3_Table(~tf90,:) 
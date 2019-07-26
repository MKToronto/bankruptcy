
% First data needs to be converted from a arff file into a table in Matlab
[Year3data, relname3, nomspec3] = arff_read('/3year.arff')
 Year3_Table_nonNormalised = struct2table(Year3data)
 
%  Then the data needs to be normalised
Year3_Table = Year3_Table_nonNormalised;
Year3_Table(:, 1:end-1) = varfun(@normc, Year3_Table_nonNormalised, 'InputVariables', 1:width(Year3_Table_nonNormalised)-1)  


% Then a training and test set need to be created
p = .7      % proportion of rows to select for training
N = size(Year3_Table,1)  % total number of rows 
tf = false(N,1)    % create logical index vector
tf(1:round(p*N)) = true     
tf = tf(randperm(N))   % randomise order
dataTraining = Year3_Table(tf,:) 
dataTesting = Year3_Table(~tf,:) 


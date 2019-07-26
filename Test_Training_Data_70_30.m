
p = .7      % proportion of rows to select for training
N = size(Year3_Table,1)  % total number of rows 
tf = false(N,1)    % create logical index vector
tf(1:round(p*N)) = true     
tf = tf(randperm(N))   % randomise order
dataTraining = Year3_Table(tf,:) 
dataTesting = Year3_Table(~tf,:) 
dataA = cumsum(ones(20,3))  % some test data
p = .7      % proportion of rows to select for training
N = size(dataA,1)  % total number of rows 
tf = false(N,1)    % create logical index vector
tf(1:round(p*N)) = true     
tf = tf(randperm(N))   % randomise order
dataTraining = dataA(tf,:) 
dataTesting = dataA(~tf,:) 
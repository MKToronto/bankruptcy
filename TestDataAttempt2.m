
tableX = Year3_Table
[trainInd,valInd,testInd] = divideint(height(tableX),0.85,0.15)
 
  Here is how to ensure a network will perform the same kind of data
  division when it is trained:
 
    net.divideFcn = 'divideblock';
    net.divideParam.trainRatio = 0.7;
    net.divideParam.valRatio = 0.15;
    net.divideParam.testRatio = 0.15.
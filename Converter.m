% [Year1data, relname1, nomspec1] = arff_read('/BData/1year.arff')
%  Year1_Table = struct2table(Year1data)
%  
%  [Year2data, relname2, nomspec2] = arff_read('/BData/2year.arff')
%  Year2_Table = struct2table(Year2data)
 
 [Year3data, relname3, nomspec3] = arff_read('/3year.arff')
 Year3_Table = struct2table(Year3data)
 
%  [Year4data, relname4, nomspec4] = arff_read('/BData/4year.arff')
%  Year4_Table = struct2table(Year4data)
%  
%  [Year5data, relname5, nomspec5] = arff_read('/BData/5year.arff')
%  Year5_Table = struct2table(Year5data)
%  
% %  
%  X = Year4_Table(:,1:64);
% Y = Year4_Table(:,65);

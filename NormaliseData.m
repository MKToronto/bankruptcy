Year3_Table(:, 1:end-1) = varfun(@normc, Year3_Table, 'InputVariables', 1:width(Year3_Table)-1)  %normalise every column but first.

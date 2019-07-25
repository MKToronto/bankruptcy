
creditDS = readtable('/Data/1year.arff');


X = [creditDS.WC_TA creditDS.RE_TA creditDS.EBIT_TA creditDS.MVE_BVTD...
     creditDS.S_TA creditDS.Industry];
Y = ordinal(creditDS.Rating);


leaf = [1 5 10];
nTrees = 25;
rng(9876,'twister');
savedRng = rng; % save the current RNG settings

color = 'bgr';
for ii = 1:length(leaf)
   % Reinitialize the random number generator, so that the
   % random samples are the same for each leaf size
   rng(savedRng);
   % Create a bagged decision tree for each leaf size and plot out-of-bag
   % error 'oobError'
   b = TreeBagger(nTrees,X,Y,'OOBPred','on',...
                             'CategoricalPredictors',6,...
                             'MinLeaf',leaf(ii));
   plot(b.oobError,color(ii));
   hold on;
end
xlabel('Number of grown trees');
ylabel('Out-of-bag classification error');
legend({'1', '5', '10'},'Location','NorthEast');
title('Classification Error for Different Leaf Sizes');
hold off;

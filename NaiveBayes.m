Mdl = fitcnb(dataTraining,'class')

[label,Posterior,Cost] = predict(Mdl,dataTesting)
Mdl.ClassNames
Mdl.Prior
Mdl.Cost
label;
cpre = predict(Mdl,dataTesting)



label

Mdl.CLevels

nonBankrupt = strcmp(Mdl.ClassNames,'0');
nonBankruptestimates = Mdl.DistributionParameters{nonBankrupt,1}

Bankrupt = strcmp(Mdl.ClassNames,'1');
Bankruptestimates = Mdl.DistributionParameters{Bankrupt,1}

figure
gscatter(X(:,1),X(:,2),Y);
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on
Params = cell2mat(Mdl.DistributionParameters);
Mu = Params(2*(1:3)-1,1:2); % Extract the means
Sigma = zeros(2,2,3);
for j = 1:3
    Sigma(:,:,j) = diag(Params(2*j,:)).^2; % Create diagonal covariance matrix
    xlim = Mu(j,1) + 4*[1 -1]*sqrt(Sigma(1,1,j));
    ylim = Mu(j,2) + 4*[1 -1]*sqrt(Sigma(2,2,j));
    ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(j,:),Sigma(:,:,j)),[xlim ylim])
        % Draw contours for the multivariate normal distributions
end
h.XLim = cxlim;
h.YLim = cylim;
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
hold off



yu=unique(y);
nc=length(yu); % number of classes
ni=size(x,2); % independent variables
ns=length(v); % test set

% compute class probability
for i=1:nc
    fy(i)=sum(double(y==yu(i)))/length(y);
end

switch distr
    
    case 'normal'
        
        % normal distribution
        % parameters from training set
        for i=1:nc
            xi=x((y==yu(i)),:);
            mu(i,:)=mean(xi,1);
            sigma(i,:)=std(xi,1);
        end
        % probability for test set
        for j=1:ns
            fu=normcdf(ones(nc,1)*u(j,:),mu,sigma);
            P(j,:)=fy.*prod(fu,2)';
        end

    case 'kernel'

        % kernel distribution
        % probability of test set estimated from training set
        for i=1:nc
            for k=1:ni
                xi=x(y==yu(i),k);
                ui=u(:,k);
                fuStruct(i,k).f=ksdensity(xi,ui);
            end
        end
        % re-structure
        for i=1:ns
            for j=1:nc
                for k=1:ni
                    fu(j,k)=fuStruct(j,k).f(i);
                end
            end
            P(i,:)=fy.*prod(fu,2)';
        end

    otherwise
        
        disp('invalid distribution stated')
        return

end

% get predicted output for test set
[pv0,id]=max(P,[],2);
for i=1:length(id)
    pv(i,1)=yu(id(i));
end

% compare predicted output with actual output from test data
confMat=myconfusionmat(v,pv);
disp('confusion matrix:')
disp(confMat)
conf=sum(pv==v)/length(pv);
disp(['accuracy = ',num2str(conf*100),'%'])

toc

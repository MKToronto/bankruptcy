function confMat=myconfusionmat(dataTestingLabels,pv)

yu=unique(v);
confMat=zeros(length(yu));
for i=1:length(yu)
    for j=1:length(yu)
        confMat(i,j)=sum(isequal(v,yu(i)) & isequal(pv,yu(j)));
    end
end
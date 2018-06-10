function [ output ] = PCA( expressions , types )

%expression -> matrix -> rows are genes & columns are samples -> n * m
%types -> type of samples  1*m

[~,scores,pcvar] = princomp(expressions');

%plot in 3 dimension(pc)
x = zscore(scores(:,1));
y = zscore(scores(:,2));
z = zscore(scores(:,3));

%2 type of samples (adenoma & normal) 
gscatter3(x,y,z,types,{'b','g'},{'.','.'},15)

xlabel(['PC-1(' num2str(round(pcvar(1)/sum(pcvar)*100)) '%)'],'fontsize',12);
ylabel(['PC-2(' num2str(round(pcvar(2)/sum(pcvar)*100)) '%)'],'fontsize',12);
zlabel(['PC-3(' num2str(round(pcvar(3)/sum(pcvar)*100)) '%)'],'fontsize',12);

end


function [ output ] = SVM_train( GEP , markers )

%markers -> genes names which identify with cell array format-> M*1
%format -> M is subnetworks-> each row is markers name cell array 
%(must be concat each row's gene names cell) 

%GEP -> genes profile N*2-> N is samples -> column 1 is gene names / column
%2 is expression cell array

%concat all subnetworks in a single cell array
genes={};
for i=1:size(markers,1)
   genes=horzcat(genes,markers{i,1});
end
genes=unique(genes);

%class for each row for biuld classifier
traingroup=cell(64,1); 
for i=1:32
   traingroup{0+i,1}='normal';
   traingroup{32+i,1}='adenoma'; 
end

% find index of genes which is in GEP
index=[];
for i=1:length(genes)
    ind=find(strcmp(GEP(:,1),genes{i}));
    index=[index,ind];
end

trainD=GEP(index,2);
trainD=cell2mat(trainD)';
svmstruct=svmtrain(trainD,traingroup);
output=svmstruct;

end


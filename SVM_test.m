function [ output ] = SVM_test( test_GEP ,svm_struct , markers)

%test_GEP -> cell matrix which first column is genes name and second column
%is corresponding expression array of genes

%markers -> genes names which identify with cell array format-> M*1
%format -> M is no. subnetworks-> each row is markers name cell array 
%(must be concat each row's gene names cell) 

%concat all subnetworks in a single cell array
genes={};
for i=1:size(markers,1)
   genes=horzcat(genes,markers{i,1});
end
genes=unique(genes)'; % dimension must be (no. unique genes) * 1

control={'normal';'normal';'normal';'normal';'normal';'normal';'normal';'normal';
    'adenoma';'adenoma';'adenoma';'adenoma';'adenoma';'adenoma';'adenoma';
    'adenoma';'adenoma';'adenoma';'adenoma';'adenoma';'adenoma';'adenoma';'adenoma';};
genes=upper(genes);
test_GEP(:,1)=upper(test_GEP(:,1));
for i=1:size(genes,1)
    index=find(strcmp(test_GEP(:,1),genes{i,1}));
    if (index)
       test(i,:)=test_GEP(index,:);
    end
end
testD=cell2mat(test(:,2))';
% testD=test_GEP(:,markers); 
group={};
for i=1:size(testD,1)
    group(i,1) = svmclassify(svm_struct,testD(i,:));   
end

correct=find(strcmp(control(:,1),group(:,1)));
acc=length(correct)/size(testD,1);
output=acc;
end


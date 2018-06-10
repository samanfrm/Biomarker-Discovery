function [ pvalues tscores DEGs ] = ttest_fdr( GEP ,genes , gpmap)
%perform Paired ttest on GEP

%gpmap -> rows r genes adn their corresponding proteins ->first
%column:genes ID / second column proteins ID 
%genes -> genes r Unique Genes Name n*1 array
%GEP -> rows r samples and column r genes
cutoff=0.01;
[pvalues, tscores] = mattest(GEP(:,1:32),GEP(:,33:64) ,'Permute', 10000,'Showhist', true, 'Showplot', true);

% compute the FDR using the Storey-Tibshirani procedure

 pFDR = mafdr(pvalues, 'BHFDR', true);
 
 tscores=abs(tscores);
 pvalues=pFDR;
 
DEGs_index=find(pFDR < cutoff);
DEGs=genes(DEGs_index,1);

for i=1:size(DEGs,1) %add genes ID to second column of DEGs
   DEGs{i,2}=DEGs_index(i);   
end

for i=1:size(DEGs,1) %add proteins ID to third column of DEGs
     DEGs{i,3}=gpmap(gpmap(:,1)==DEGs{i,2},2);    
end
end


function [ output ] = T_score( gpmap,tscore )

newTscore=zeros(size(gpmap,1),1);
for i=1:size(gpmap,1)
    newTscore(i,1)=tscore(gpmap(i,1));
end
output=newTscore;
end


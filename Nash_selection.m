function [ output ] = Nash_selection( gpmap , subgames )

% choose one nash which has max tscore average

agents=subgames{1,1};
nashs=subgames{1,2};
scores=zeros(size(nashs,1),1); 
for i=1:size(nashs,1) 
    state=nashs{i,1};
    sum=0;
    nnz=0;
    for j=1:length(state)
       if(str2double(state(j)))
           sum=sum+gpmap(gpmap(:,2)==agents(j),3); % sum with tscore off that agent    
           nnz=nnz+1;
       end  
    end
    scores(i)=sum/nnz;    
end
[c ind]=max(scores);
output.agents=agents;
output.nash=nashs{ind,1};
output.value=c;
end


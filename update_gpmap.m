function [ output ] = update( agentset , gpmap )
newgp=[];
for i=agentset
    newgp=vertcat(newgp,gpmap(gpmap(:,2)==i,:));    
end
output=newgp;
end


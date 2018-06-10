function [ output ] = local_information( newppin,gpmap,agent,agentset,alpha )

neighboursfull=find(newppin(agentset.agents==agent,:));
levels=agentset.agents_lvl;
for i=1:length(levels)
   if(~isempty(find(levels{i}==agent, 1))) 
       lvl=i;
       break;
   end 
end
if(lvl~=length(levels))
   nextlvl_neigh=agentset.agents_lvl{lvl+1}; 
else
    nextlvl_neigh=[];
end
neighbours=intersect(agentset.agents(neighboursfull),nextlvl_neigh);
localinfo=0;
if(~isempty(neighbours))
    for i=1:length(neighbours)
        localinfo=localinfo+ gpmap(gpmap(:,2)==neighbours(i),3);
        % can use density and (-loss) more   
    end
    output=localinfo * alpha;
else
    output=localinfo * alpha;
end
end


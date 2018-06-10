function [ output ] = DEG( agents,gpmap ,DEGs)
         all_agents=agents.agents; % all agents in subnetwork
         all_Endlvl=agents.agents_lvl{3}; % end level of subnetwork
         subgames=agents.subgames; % all agents in subgame
         for i=1:size(subgames,1)
             agents_Endlvl=subgames{i,3};
             agents_Endlvl=intersect(agents_Endlvl,cell2mat(DEGs(:,3))');
             if(length(agents_Endlvl)>11) % total size of agents in subgame must be <= 25                  
                   for j=1:length(agents_Endlvl)
                     gpmap2(j,:)=gpmap(gpmap(:,2)==agents_Endlvl(j),:);     
                   end
                   gpmap2=sortrows(gpmap2,3);                 
                   k=1;
                  while(length(agents_Endlvl)>11)
                    all_agents(all_agents==gpmap2(k,2))=[]; % remove from list of all subnetwork agents
                    all_Endlvl(all_Endlvl==gpmap2(k,2))=[]; % remove from list of all end lvl subnetwotk agents
                    agents_Endlvl(agents_Endlvl==gpmap2(k,2))=[]; %remove from list of end level of subgame
                    k=k+1;
                  end
                  subgames{i,3}=agents_Endlvl;
             end
         end
         agents.agents=all_agents;
         agents.agents_lvl{3}=all_Endlvl;
         agents.subgames=subgames;
         output=agents; 
end


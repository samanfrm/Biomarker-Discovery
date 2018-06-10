function [ output ] = setplayers(PPIN,geneindex,gpmap,d)
 index= gpmap(gpmap(:,1)==geneindex,2);% find protein index in gpmap 
 agents=bfs(PPIN,index,d , gpmap); % with reduced level 1 nodes
%  agents_Endlvl=agents.agents_lvl{length(agents.agents_lvl)};
%  a=unique(agents_Endlvl);
  if(d>=1) %if d=2        
     parent=agents.agents_lvl{1};
     agents_lvl2=agents.agents_lvl{2};
     agents_Endlvl=agents.agents_lvl{3};
     subgames=cell(length(agents_lvl2),3);
     for i=1:length(agents_lvl2)
        subgames{i,1}=parent;
        subgames{i,2}=agents_lvl2(i);
        neighbours=find(PPIN(agents_lvl2(i),:)); % return all neghbour in PPIN
        neighbours(neighbours==parent)=[]; % without start node
        neighbours(find(ismember(neighbours,agents_lvl2)))=[];% all neghbour without level 1 nodes   
        if(length(neighbours)>10)
           subgames{i,3}=clustering_coeff1(agents_lvl2(i),neighbours,PPIN , gpmap);
        else
           subgames{i,3}= neighbours;
        end
%       subgames{i,3}=intersect(neighbours,agents_Endlvl);
%       agents_Endlvl(ismember(agents_Endlvl,subgames{i,3}))=[];
     end
     agents.subgames=subgames;
%     agents=clustering_coeff(agents,PPIN)
%     output=DEG(agents , gpmap ,DEGs);
     output=agents;
 else
     output=agents; 
  end
end


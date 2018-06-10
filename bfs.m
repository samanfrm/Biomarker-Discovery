function [ output ] = bfs( PPIN ,start,d ,gpmap )

queue(1,1)=start;
agents=[];
agents=horzcat(agents,start);
depth=0;
agents_lvl{depth+1}=start;
lastchild=start;
while (length(queue)~=0) && (depth<d)
    parent=queue(1);
    queue(1)=[];   
    childs=find(PPIN(parent,:));
    
    % cluster coeff start_node's neighbours
    if(parent==start)
       childs=clustering_coeff1(parent,childs,PPIN ,gpmap);    
    end
    
    for i=1:length(childs)
       if(childs(i)~=parent && childs(i)~=start) % && ~ismember(childs(i),agents)
           queue=horzcat(queue,childs(i));
           agents=horzcat(agents,childs(i));
       end
    end
    
    if(parent==lastchild)        
       depth=depth+1;
       agents_lvl{depth+1}=queue; % save next level nodes
       lastchild=queue(end);
    end
end
a=unique(agents);
output.agents=agents;
output.agents_lvl=agents_lvl;
end


function [ output ] = Main(PPIN,gpmap,tscore,DEGs,degree,p_gname)

tscore=T_score(gpmap,tscore);
tmean=mean(tscore);%get mean of t-score of all genes
%degree=getdegree(PPIN)';
degmean=mean(degree);
gpmap=horzcat(gpmap,tscore);% genes and its proteins and degree
gpmap=horzcat(gpmap,degree);
gpmap=sortrows(gpmap,-3);     % sort gpmap rows by tscore
iterate=50;  %number of subnetwork that could find
for i=1:size(gpmap,1)
     geneindex=gpmap(i,1);
%    score=gpmap(i,3);
     deg=gpmap(i,4); %access degree of gene i 
     if(deg >= degmean)
%     if(deg>=5)
              agents=setplayers(PPIN,geneindex,gpmap,2);% run bfs and return d connected around nodes
              for j=1:size(agents.subgames) % static game for every subgame
                   agentset=cell2mat(agents.subgames(j,:));
                   agents2.agents=agentset;
                   agents2.agents_lvl=agents.subgames(j,:);
                   gpmap2=update_gpmap(agentset,gpmap); % for reduce & fit gpmap size to agentset
                   payoffmat=payoff(agents2,PPIN,gpmap2); % calculate peyoff table
                   subgames{j,1}=agentset;
                   subgames{j,2}=findnash(payoffmat);% find nashes
                   if(~isempty(subgames{j,2}))%there is no Nash
                       nash=Nash_selection(gpmap2,subgames(j,:));% choose single nash per subgame
                       subgames{j,1}=nash.agents;
                       subgames{j,2}=nash.nash;
                       subgames{j,3}=nash.value;
                   else
                       subgames(j,:)=[];
                   end
              end
              subnet=Merge_subgames(subgames,p_gname);
              subnetworks{iterate,1}=subnet.markers;
              subnetworks{iterate,2}=subnet.value;
              iterate=iterate-1;
    end  
    if(iterate==0)
       break; 
    end
end
 output=(flipdim(subnetworks));
end


function [ output ] = Merge_subgames( subgames , p_gname )

subnetwork=[];
for i=1:size(subgames,1)
   state=subgames{i,2};
   agents=subgames{i,1};
   for j=1:length(state)
      if(str2double(state(j)))
          subnetwork=[subnetwork agents(j)];
      end
   end   
end
subnetwork=unique(subnetwork);
markers={};
for i=1:length(subnetwork)
    markers{i}=p_gname{subnetwork(i),2};
end
value=mean(cell2mat(subgames(:,3)));
output.markers=markers;
output.value=value;
end


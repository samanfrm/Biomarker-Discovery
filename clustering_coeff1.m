function [ output ] = clustering_coeff1( start,neighbours , PPIN ,gpmap )

lvl_1_2=cell2mat({start neighbours});
newPPIN=PPIN(lvl_1_2,lvl_1_2);
newPPIN(find(newPPIN))=1;
co=clustcoeff(newPPIN);% without remove any lvl_1 neighnours 
for i=2:length(lvl_1_2)
    degree=getdegree(newPPIN);% degree of lvl_1_2
    [~, ind]=min(degree(2:end));
    newPPIN(ind+1,:)=[];
    newPPIN(:,ind+1)=[];
    degree(ind+1)=[];
    dbstop if error
    co2=clustcoeff(newPPIN); %mean of all clustering coefficients or just node 1 (start node) clust coeff
    if(isempty(co2)) %minimuim one node at least
       break; 
    end
    if(co2(1)>co(1))
        neighbours(ind)=[];
    else
       break; 
    end
    co=co2;
end  
% reduce subgame to 10+2 nodes
if (length(neighbours)>10)
   a=neighbours';
   index=[];
   for i=1:length(neighbours)
     a(i,2)=gpmap(gpmap(:,2)==neighbours(i),3);
   end
   a=sortrows(a,-2);
   neighbours=a(1:10,1)';
end
output=neighbours;
end


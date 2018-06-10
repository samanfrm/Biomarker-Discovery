function [ output ] = density( PPIN )

%agent = protein number

%subnetwork with specific agent
subnetworkadj=PPIN;
len=length(subnetworkadj);
weigth=sum(sum(subnetworkadj));
density1=weigth/((len) * (len-1));

%subnetwork without specific agent
% agentset(find(agentset==agent))=[];
% subnetworkadj=PPIN(agentset,agentset);
% len=length(subnetworkadj);
% weigth=sum(subnetworkadj(find(subnetworkadj)));
% density2=weigth/((len) * (len-1));
% output=density1 - density2;

output=density1;
end


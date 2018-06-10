function [ output ] = update_ppin( state,PPIN,agentset )

for i=1:length(agentset)
   if(str2double(state(i))==0)
          PPIN(i,:)=0;
          PPIN(:,i)=0;
   end
end
output=PPIN;
end


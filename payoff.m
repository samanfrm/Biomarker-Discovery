function [ output ] = payoff( agentset,PPIN,gpmap )

len=length(agentset.agents);
gpmap=update_gpmap(agentset.agents,gpmap);% just use subnetwork's node in gpmap
PPIN=PPIN(agentset.agents,agentset.agents); % just use subnetwork in PPIN 
ptable=zeros(2^len - (2^len)/2 ,2);
ptable=num2cell(ptable);
alpha1=1.2; % tscore const factor
alpha2=1; % density const factor
alpha3=1; % local-info const factor
C=2; % loss function const 
m=1;
for i=(2^len )/2 : 2^len-1
    state=dec2bin(i);%state of 0 or 1 strategies for every agents in subnetwork
    ptable{m,1}=state;
    newppin=update_ppin(state,PPIN,agentset.agents);
   % newppin=PPIN;
    payoff=zeros(1,len);
    dense=density(newppin) * alpha2;%calculate density of subnetwork
    lls=loss_f(state) * C ; %linear loss function ***(find(str2num(state))~=0)-1))
    for j=1:len
       if(str2double(state(j))==1)% payoff for choose stay strategy
             payoff(j)=gpmap(gpmap(:,2)==agentset.agents(j),3) * alpha1;
             payoff(j)=payoff(j)+dense;
            %  dbstop if error
             payoff(j)=payoff(j)+ (local_information(newppin,gpmap,agentset.agents(j),agentset,alpha1) * alpha3);
             payoff(j)=payoff(j)- lls;
       else
             payoff(j)=gpmap(gpmap(:,2)==agentset.agents(j),3);
             payoff(j)=payoff(j)+dense;
            % payoff(j)=payoff(j) - local_information(tscore,newppin,gpmap,agentset.agents(j),agentset);
%             payoff(j)=payoff(j)- lls;
       end
    end
    ptable{m,2}=payoff;
    m=m+1;
end
output=ptable;
end

